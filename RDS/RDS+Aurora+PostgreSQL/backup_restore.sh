HOST_ORIGIN=bia.co70gok8o718.us-east-1.rds.amazonaws.com
HOST_TARGET=bia-serverless.cluster-co70gok8o718.us-east-1.rds.amazonaws.com
USER_ORIGIN=postgres
USER_TARGET=postgres
DATABASE_ORIGIN=bia
DATABASE_TARGET=bia
FILE=dump_bia.tar

chmod 0600 .pgpass

echo 'Testing connection to origin  database'
PGPASSFILE=.pgpass pg_isready -d $DATABASE_ORIGIN -h $HOST_ORIGIN -p 5432 -U $USER_ORIGIN

echo 'Starting backup'
PGPASSFILE=.pgpass pg_dump -d $DATABASE_ORIGIN -h $HOST_ORIGIN -U $USER_ORIGIN --clean --no-privileges --no-owner --verbose --file $FILE

echo 'Testing connection to target database'
PGPASSFILE=.pgpass pg_isready -d $DATABASE_TARGET -h $HOST_TARGET -p 5432 -U $USER_TARGET

echo 'Closing connections to target database'
PGPASSFILE=.pgpass psql -d postgres -h $HOST_TARGET -p 5432 -U $USER_TARGET -c "SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname='$DATABASE_TARGET' AND pid <> pg_backend_pid();"

echo 'Dropping target database'
PGPASSFILE=.pgpass dropdb -h $HOST_TARGET -p 5432 -U $USER_TARGET $DATABASE_TARGET

echo 'Creating target database'
PGPASSFILE=.pgpass createdb -h $HOST_TARGET -p 5432 -U $USER_TARGET $DATABASE_TARGET

echo 'Restoring backup to target database'
PGPASSFILE=.pgpass psql -d $DATABASE_TARGET -h $HOST_TARGET -p 5432 -U $USER_TARGET -e -f $FILE
