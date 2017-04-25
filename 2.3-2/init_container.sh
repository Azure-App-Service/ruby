#!/bin/bash
service ssh start
touch /home/LogFiles/ruby_${WEBSITE_ROLE_INSTANCE_ID}_out.log
echo "$(date) Container started, server output will be sent to docker logs" >> /home/LogFiles/ruby_${WEBSITE_ROLE_INSTANCE_ID}_out.log
bash /opt/startup.sh

