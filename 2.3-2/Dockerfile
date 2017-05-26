FROM buildpack-deps:jessie-curl
MAINTAINER Azure App Services Container Images <appsvc-images@microsoft.com>

COPY init_container.sh /bin/
COPY startup.sh /opt/
COPY sshd_config /etc/ssh/
COPY splashsite.zip /tmp
COPY hostingstart.html /home/site/wwwroot/hostingstart.html

RUN apt-get update -qq 

# Dependencies for various ruby and rubygem installations
RUN apt-get install -y git --no-install-recommends 
RUN apt-get install -y libreadline-dev bzip2 build-essential libssl-dev zlib1g-dev libpq-dev libsqlite3-dev \
  curl patch gawk g++ gcc make libc6-dev patch libreadline6-dev libyaml-dev sqlite3 autoconf \
  libgdbm-dev libncurses5-dev automake libtool bison pkg-config libffi-dev bison libxslt-dev \
  libxml2-dev libmysqlclient-dev --no-install-recommends

# rbenv 
RUN git clone https://github.com/rbenv/rbenv.git /usr/local/.rbenv
RUN chmod -R 777 /usr/local/.rbenv

ENV RBENV_ROOT="/usr/local/.rbenv"

ENV PATH="$RBENV_ROOT/bin:/usr/local:$PATH"

RUN git clone https://github.com/rbenv/ruby-build.git /usr/local/.rbenv/plugins/ruby-build
RUN chmod -R 777 /usr/local/.rbenv/plugins/ruby-build

RUN /usr/local/.rbenv/plugins/ruby-build/install.sh

# Install ruby 2.3.3
ENV RUBY_CONFIGURE_OPTS=--disable-install-doc

ENV RUBY_CFLAGS=-O3

RUN eval "$(rbenv init -)" \
  && export WEBSITES_LATEST_NODE_VERSION="2.3.3" \
  && rbenv install $WEBSITES_LATEST_NODE_VERSION \
  && rbenv rehash \
  && rbenv global $WEBSITES_LATEST_NODE_VERSION \
  && ls /usr/local -a \
  && gem install bundler --version "=1.13.6"\
  && chmod -R 777 /usr/local/.rbenv/versions \
  && chmod -R 777 /usr/local/.rbenv/version

RUN eval "$(rbenv init -)" \
  && rbenv global $WEBSITES_LATEST_NODE_VERSION \
  && bundle config --global build.nokogiri -- --use-system-libraries

# Because Nokogiri tries to build libraries on its own otherwise
ENV NOKOGIRI_USE_SYSTEM_LIBRARIES=true

# SQL Server gem support
RUN apt-get install -y unixodbc-dev freetds-dev freetds-bin

# Make temp directory for ruby images
RUN mkdir -p /tmp/bundle
RUN chmod 777 /tmp/bundle

RUN apt-get update -qq \
    && apt-get install -y nodejs unzip openssh-server dos2unix --no-install-recommends \
    && echo "root:Docker!" | chpasswd

RUN unzip -q /tmp/splashsite.zip -d /opt/splash 

RUN eval "$(rbenv init -)" \
  && rbenv global 2.3.3 \
  && cd /opt/splash/splash; bundle install --deployment

RUN chmod 755 /bin/init_container.sh \
  && mkdir -p /home/LogFiles/ \
  && chmod 755 /opt/startup.sh

EXPOSE 2222 8080

ENV PORT 8080
ENV WEBSITE_ROLE_INSTANCE_ID localRoleInstance
ENV WEBSITE_INSTANCE_ID localInstance

WORKDIR /home/site/wwwroot

ENTRYPOINT [ "/bin/init_container.sh" ]