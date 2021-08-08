#!/bin/bash

yum update -y
amazon-linux-extras install docker -y
service docker start
usermod -a -G docker ec2-user

export DATABASE_URL="${database_url}"

docker container run -e DATABASE_URL="$DATABASE_URL" --rm --name migrations vbil/kittens-store:multi-stage bundle exec rake db:create db:migrate db:seed
docker container run -e DATABASE_URL="$DATABASE_URL" -p 80:1234 --name app vbil/kittens-store:multi-stage bundle exec rackup --port 1234 --host 0.0.0.0

