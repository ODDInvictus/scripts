#! /bin/bash

d=$(date +%Y%m%d)
echo "Starting backup of mariadb on $d"

# Source utils.sh and load all variables
source $(dirname $0)/utils.sh
source $(dirname $0)/conf

# Check if the required variables for this script are set
check_vars MARIADB_ROOT_PASSWORD MARIADB_BACKUP_DBS BACKUP_FOLDER DOCKER_MARIADB_NAME
 
# Now we can dump the dbs
for db in "${MARIADB_BACKUP_DBS[@]}"; do
  echo "Backing up database:$db"
  
  # create a folder called $db if it does not exist
  if [ ! -d $BACKUP_FOLDER/$db ]
  then
    mkdir $BACKUP_FOLDER/$db
  fi

  name="${db}_${d}.sql"
  # Now actually dump the database
  docker exec $DOCKER_MARIADB_NAME mysqldump --user root -p"$MARIADB_ROOT_PASSWORD" $db > $BACKUP_FOLDER/$db/$name
done