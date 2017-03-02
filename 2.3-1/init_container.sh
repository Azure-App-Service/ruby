#!/bin/bash
service ssh start
touch /home/LogFiles/ruby_$WEBSITE_ROLE_INSTANCE_ID_out.log
echo "$(date) Container started" >> /home/LogFiles/ruby_$WEBSITE_ROLE_INSTANCE_ID_out.log

