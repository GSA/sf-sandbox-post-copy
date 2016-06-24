#!/bin/bash
# http://blog.deadlypenguin.com/blog/2015/04/22/travis-ci-salesforce/

set -ev

SOL_ROOT="$TRAVIS_BUILD_DIR/build/solenopsis/scripts"

cd $SOL_ROOT
./bsolenopsis destructive-push
