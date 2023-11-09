#!/bin/bash

mkdir -p postgres-upgrade-testing
cd postgres-upgrade-testing || exit
OLD='12'
NEW='16'
DBname='gitlab'                   #DBname can only be lowercase
SQLFILE='/home/user/tmp/gitlab.sql'

echo "Create Old PostgreSQL container..."
docker run -dit --name postgres-upgrade-testing -e POSTGRES_PASSWORD=password -v "$PWD/$OLD/data":/var/lib/postgresql/data "postgres:$OLD"
sleep 3
echo " "
echo "Container Created"

echo " "
echo "Create Old Database..."
docker exec -i postgres-upgrade-testing psql -U postgres -c "CREATE DATABASE $DBname;"
echo " "
echo "Insert $DBname sql file"
cat $SQLFILE | docker exec -i postgres-upgrade-testing psql -U postgres -d $DBname  &> /dev/null
echo " "
echo "Remove old Container"
docker stop postgres-upgrade-testing
docker rm postgres-upgrade-testing

echo " "
echo "Upgrading Database..."
docker run --rm -v "$PWD":/var/lib/postgresql "tianon/postgres-upgrade:$OLD-to-$NEW" --link

echo " "
echo "Processing New PostgreSQL..."
docker run -dit --name postgres-upgrade-testing -e POSTGRES_PASSWORD=password -v "$PWD/$NEW/data":/var/lib/postgresql/data "postgres:$NEW"
sleep 3

echo " "
echo "Exporting New PostgreSQL file..."
datetime=$(date +%Y-%m-%d_%H_%M_%S)
docker exec -i postgres-upgrade-testing pg_dump -U postgres $DBname | sudo tee "../${DBname}_dump_${datetime}.sql" > /dev/null
sleep 3
sudo chown "$USER":"$USER" "../${DBname}_dump_${datetime}.sql"
cd ..

echo " "
echo "Done"

docker stop postgres-upgrade-testing
docker rm postgres-upgrade-testing
docker rmi "postgres:$OLD" "postgres:$NEW"
sudo rm -fr postgres-upgrade-testing
docker rmi "tianon/postgres-upgrade:$OLD-to-$NEW"
unset OLD NEW DBname SQLFILE datetime

echo " "
echo "Container Deleted"
