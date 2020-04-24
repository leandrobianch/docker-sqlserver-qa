#!/bin/bash

log() {
    
    patternLog="$(date +'%y-%m-%d-%H:%M:%S') script sh - $1"
    
    echo $patternLog

    echo $patternLog >> $FILE_LOG_SQL_SERVER
}






