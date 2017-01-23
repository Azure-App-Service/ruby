FROM ruby:2.3
MAINTAINER James Christianson <jamchri@microsoft.com>
RUN apt-get update -qq && apt-get install -y nodejs unzip --no-install-recommends

# Install passenger
RUN gem install rubygems-bundler
RUN gem regenerate_binstubs 
RUN gem install --no-user-install passenger
RUN mkdir -p /usr/local/passenger/logs
RUN ln -s /home/LogFiles /usr/local/passenger/logs

COPY splashsite.zip /tmp
RUN unzip -q /tmp/splashsite.zip -d /opt/splash 

RUN cd /opt/splash/splash; bundle install --deployment

HEALTHCHECK CMD curl --fail http://localhost:3000/ || exit 1 
