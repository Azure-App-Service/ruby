echo 'Starting ssh server'
service ssh start

if [ -n "$SECRET_KEY_BASE" ]
  then
    echo 'Secret key base present'
  else
    echo 'Generating a secret key base'
    export SECRET_KEY_BASE=$(ruby -rsecurerandom -e 'puts SecureRandom.hex(64)')
fi

if [ -n "$RAILS_ENV" ]
  then
    echo 'RAILS_ENV set to $RAILS_ENV'
  else
    echo 'RAILS_ENV not set, default to production'
    export RAILS_ENV='production'
fi

echo 'Removing any leftover pids if present'
rm -f tmp/pids/* ;

bundle config --local path "vendor/bundle"
if bundle check | grep satisfied
  then
    echo 'dependency check passed'
  else
    echo 'missing dependencies, try redeploying'
    exit -1
fi

if [ -n "$APP_COMMAND_LINE" ]
  then
    echo 'using command: $APP_COMMAND_LINE'
  else
    echo 'defaulting to command: "rails server -e $RAILS_ENV"'
    export APP_COMMAND_LINE="rails server -e $RAILS_ENV"
fi

echo "Executing $APP_COMMAND_LINE"
$APP_COMMAND_LINE
