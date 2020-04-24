#command line sqlcmd execute scripts
export SQL_CMD=/opt/mssql-tools/bin/sqlcmd

# general configs for logs
PATH_LOG=ci/logs
FILE_LOG_SQL_SERVER=$PATH_LOG/log.txt

# log results execute scripts sql
QUERY_RESULT_FILE=$PATH_LOG/query-result.txt

# folder scripts .sql
SCRIPTS_FOLDER=./scripts

# sqlserver configurations
export HOST_NAME_SQL_SERVER=localhost 
export USER_SA=sa
export SA_PASSWORD=Admin@123 
export DATABASE_NAME=test_db_8 
export USERNAME_APPLICATION=application_user 
export PASSWORD_APPLICATION=Pass_word_123 
export CONTAINER_NAME=sqlserver-qa
