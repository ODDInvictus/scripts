#! /bin/bash

d=$(date +%Y%m%d)
echo "Starting sync on $d"

# Source utils.sh and load all variables
source $(dirname $0)/utils.sh
source $(dirname $0)/conf

# Check if the required variables for this script are set
check_vars BACKUP_FOLDER REMOTE_HOST REMOTE_USER REMOTE_DIR REMOTE_PORT

# Now check if rsync is installed
if ! command -v rsync &> /dev/null
then
  echo "Please install rsync first (sudo dnf install rsync)"
  exit 1
fi

# Now sync to the remote server
rsync -azP -e "ssh -p $REMOTE_PORT" $BACKUP_FOLDER $REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR