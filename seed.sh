#!/bin/bash

echo "seeding"
/usr/local/bin/download_data.sh
if [ $? == 0 ]
then
  echo "updating mongodb"
  /usr/local/bin/seed_alignment.rb
else
  echo "there was a problem!"
fi
