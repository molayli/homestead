#!/usr/bin/env bash

name=$1
path=$2
numprocs=$3
user=$4



supervisorTpl="[program:laravel-worker-$name]
process_name=%(program_name)s_%(process_num)02d
command=php $path/artisan queue:work --queue=$name --sleep=3 --tries=2
autostart=true
autorestart=true
user=$user
numprocs=$numprocs
redirect_stderr=true
stdout_logfile=/var/log/worker-$name.log
"




echo "$supervisorTpl" > "/etc/supervisor/conf.d/laravel_worker_$name.conf"
