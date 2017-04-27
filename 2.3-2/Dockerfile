FROM ruby:2.3.3
MAINTAINER Azure App Services Container Images <appsvc-images@microsoft.com>

COPY init_container.sh /bin/
COPY startup.sh /opt/

RUN apt-get update -qq \
    && apt-get install -y nodejs unzip openssh-server dos2unix --no-install-recommends \
    && chmod 755 /bin/init_container.sh \
    && echo "root:Docker!" | chpasswd

COPY sshd_config /etc/ssh/

# Rollback bundler version for deployment reasons (14 had a breaking change for us)
RUN gem uninstall -i /usr/local/lib/ruby/gems/2.3.0 bundler
RUN gem install bundler --version "=1.13.6"

# Install passenger (unused now as we only run rails server)
RUN gem install rubygems-bundler
RUN gem regenerate_binstubs 
RUN gem install --no-user-install passenger

COPY splashsite.zip /tmp
RUN unzip -q /tmp/splashsite.zip -d /opt/splash 

RUN cd /opt/splash/splash; bundle install --deployment

RUN dos2unix /opt/startup.sh

#HEALTHCHECK CMD curl --fail http://localhost:3000/ || exit 1 

EXPOSE 2222

#CMD ["/bin/init_container.sh"]

