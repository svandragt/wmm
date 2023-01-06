#!/usr/bin/env bash

# Configuration

## see 10-php.sh for available options
export PHP_VERSION="8.0"

if [[ -f 'composer.json' ]]; then
  export USE_COMPOSER=1
else
  export USE_COMPOSER=0
fi
echo "Use Composer: $USE_COMPOSER"
exit
