#!/bin/bash

# requires valid root credentials in /root/.my.cnf

MYSQL=mysql
MYSQLDUMP=mysqldump

databases=`$MYSQL -e "SHOW DATABASES;" | grep -Evi "(Database|information_schema)" | grep -v ^performance_schema$`

for db in $databases; do

  # check if there are any tables with a non-transactional engine in db
  # disable locking only if no such table is present to ensure consistency
  # if you want hot backups (no locking) make sure to use InnoDB for all tables
  nontransactional=`$MYSQL -e "SELECT ENGINE FROM information_schema.TABLES WHERE TABLE_SCHEMA = '$db';" | grep -Evi "(ENGINE|InnoDB)"`
  if [ -z "$nontransactional" ]
  then
    NO_LOCKING="--single-transaction --quick"
  fi

  $MYSQLDUMP $NO_LOCKING --routines --triggers $db | gzip > ${db}.sql.gz
  NO_LOCKING=""

done
