#!/bin/bash

executeCommandSqlServer() {
    
    sql=$1

    log "$sql"

    docker exec -d $CONTAINER_NAME $SQL_CMD -S $HOST_NAME_SQL_SERVER -U $USER_SA -P $SA_PASSWORD -q "$sql"

    log "executeCommandSqlServer..."  
}

executeCommandScriptInlineSqlServer() {
    
    sqlFile=$1

    log "sqlcmd -S $HOST_NAME_SQL_SERVER -U $USER_SA -P $SA_PASSWORD -d $DATABASE_NAME -i '$sqlFile'"

    docker exec -d $CONTAINER_NAME $SQL_CMD -S $HOST_NAME_SQL_SERVER -U $USER_SA -P $SA_PASSWORD -d $DATABASE_NAME -i "$sqlFile" -o $QUERY_RESULT_FILE

    log "executed executeCommandScriptInlineSqlServer..."  
}

executeScriptsInitialData() {                     
 
    for sqlScript in "$SCRIPTS_FOLDER/*.sql"
    do
        executeCommandScriptInlineSqlServer $sqlScript
    done

    log "executed executeScriptsInitialData..."              
}






