FROM appsvc/rubybase:2.3.3
MAINTAINER Azure App Services Container Images <appsvc-images@microsoft.com>

COPY init_container.sh /bin/
COPY startup.sh /opt/
COPY sshd_config /etc/ssh/
COPY hostingstart.html /home/site/wwwroot/hostingstart.html
COPY staticsite.rb /opt/staticsite.rb

RUN apt-get update -qq \
    && apt-get install -y nodejs openssh-server vim curl wget tcptraceroute --no-install-recommends \
    && echo "root:Docker!" | chpasswd \
    && echo "cd /" >> /etc/bash.bashrc

RUN eval "$(rbenv init -)" \
  && rbenv global 2.3.3

RUN chmod 755 /bin/init_container.sh \
  && mkdir -p /home/LogFiles/ \
  && chmod 755 /opt/startup.sh

EXPOSE 2222 8080

ENV PORT 8080
ENV WEBSITE_ROLE_INSTANCE_ID localRoleInstance
ENV WEBSITE_INSTANCE_ID localInstance
ENV PATH ${PATH}:/home/site/wwwroot

WORKDIR /home/site/wwwroot

ENTRYPOINT [ "/bin/init_container.sh" ]
