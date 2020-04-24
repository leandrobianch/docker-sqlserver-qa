#!/bin/bash
#import another scripts
. ./ci/config.sh
. ./ci/infra/log.sh 
. ./ci/sqlserver.sh


waitingSqlReady() {

    CONTAINER_STATUS=$(docker inspect --format='{{json .State.Health.Status}}' $CONTAINER_NAME)
    
    if [ -z $CONTAINER_STATUS ]; then
        
        log "Container not found - status: $CONTAINER_STATUS"
        
        exit 0
    fi;

    until test $CONTAINER_STATUS = "\"healthy\""; do
        
        log "Status current: $CONTAINER_STATUS"
        
        sleep 1
        
        CONTAINER_STATUS=$(docker inspect --format='{{json .State.Health.Status}}' $CONTAINER_NAME)
        
        if [ -z $CONTAINER_STATUS ]; then
        
            log "Container crashed - status: $CONTAINER_STATUS"
        
            exit 1
        fi;
    done
}

startContainer () {
  
   docker-compose -f docker-compose-sql-server-qa.yml up -d 
   
   log "Compose Services UP"
}

executeInitialSql () {
    
    executeCommandSqlServer "CREATE DATABASE $DATABASE_NAME"

    executeCommandSqlServer "USE $DATABASE_NAME;CREATE LOGIN $USERNAME_APPLICATION WITH PASSWORD='$PASSWORD_APPLICATION',DEFAULT_DATABASE=$DATABASE_NAME;CREATE USER $USERNAME_APPLICATION FOR LOGIN $USERNAME_APPLICATION;EXEC sp_addrolemember N'db_datareader',N'$USERNAME_APPLICATION';EXEC sp_addrolemember N'db_datawriter',N'$USERNAME_APPLICATION'"

    executeScriptsInitialData

    log "Initial database executed !"
}

stopContainer () {
    
    sleep 160
    
    docker-compose -f docker-compose-sql-server-qa.yml down
    
    log "Compose Services DOWN"
}


inicializeLog() {
    
    clearAllLogs

    mkdir -p $PATH_LOG
    touch $QUERY_RESULT_FILE
    touch $FILE_LOG_SQL_SERVER
}

clearAllLogs() {

    if [ -d $PATH_LOG ]
    then        
        rm -rf $PATH_LOG        
    fi
}

init() {

    inicializeLog

    startContainer
    
    waitingSqlReady

    log "Ready status: $CONTAINER_STATUS"

    executeInitialSql

    stopContainer
}

init





