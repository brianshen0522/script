#!/bin/bash


mkdir -p postgres-upgrade-testing
cd postgres-upgrade-testing || exit
OLD='12'
NEW='15'
DBname='testdb'                   #DBname can only be lowercase
SQLFILE='./testDB_backup.sql'

echo "Create Old PostgreSQL container..."
docker run -dit --name postgres-upgrade-testing -e POSTGRES_PASSWORD=password -v "$PWD/$OLD/data":/var/lib/postgresql/data "postgres:$OLD"
sleep 1
echo " "
echo "Container Created"

echo " "
echo "Processing Old PostgreSQL..."
docker exec -i postgres-upgrade-testing psql -U postgres -c "CREATE DATABASE $DBname;"
cat $SQLFILE | docker exec -i postgres-upgrade-testing psql -U postgres -d $DBname  &> /dev/null
docker stop postgres-upgrade-testing
docker rm postgres-upgrade-testing

echo " "
echo "Upgrading Database..."
docker run --rm -v "$PWD":/var/lib/postgresql "tianon/postgres-upgrade:$OLD-to-$NEW" --link

echo " "
echo "Processing New PostgreSQL..."
docker run -dit --name postgres-upgrade-testing -e POSTGRES_PASSWORD=password -v "$PWD/$NEW/data":/var/lib/postgresql/data "postgres:$NEW"
sleep 1

echo " "
echo "Exporting New PostgreSQL file..."
datetime=$(date +%Y-%m-%d_%H_%M_%S)
docker exec -i postgres-upgrade-testing pg_dump -U postgres $DBname | sudo tee "../${DBname}_dump_${datetime}.sql" > /dev/null
sleep 1
sudo chown "$USER":"$USER" "../${DBname}_dump_${datetime}.sql"
cd ..

echo " "
echo "Done"

docker stop postgres-upgrade-testing
docker rm postgres-upgrade-testing
docker rmi "postgres:$OLD" "postgres:$NEW"
sudo rm -fr postgres-upgrade-testing
unset OLD NEW DBname SQLFILE datetime

echo " "
echo "Container Deleted"
