#!/bin/sh
sysctl -w vm.max_map_count=262144
docker compose up -d
until curl "http://localhost:7512/?pretty"; do sleep 10; done
./adminauth.sh
dart pub get
