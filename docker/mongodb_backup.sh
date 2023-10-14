#!/bin/bash

read -r -p "Backup Path(default: ./mongodb-backup/)" BACKUP_PATH
BACKUP_PATH_DEFAULT="./mongodb-backup/"
BACKUP_PATH="${BACKUP_PATH:-$BACKUP_PATH_DEFAULT}"

read -r -p "Backup Log Path(default: ./${BACKUP_PATH}/backup.log)" BACKUP_LOG_PATH
BACKUP_LOG_PATH_DEFAULT="./${BACKUP_PATH}/backup.log"
BACKUP_LOG_PATH="${BACKUP_LOG_PATH:-$BACKUP_LOG_PATH_DEFAULT}"

read -r -p "MongoDB Username (default: root)" MONGODB_USER
MONGODB_USER_DEFAULT="root"
MONGODB_USER="${MONGODB_USER:-$MONGODB_USER_DEFAULT}"

read -r -p "MongoDB Password (default: mongo1234)" MONGODB_PWD
MONGODB_PWD_DEFAULT="mongo1234"
MONGODB_PWD="${MONGODB_PWD:-$MONGODB_PWD_DEFAULT}"

read -r -p "MongoDB Database Name" MONGODB_DB_NAME
MONGODB_DB_NAME_DEFAULT="mongo1234"
MONGODB_DB_NAME="${MONGODB_DB_NAME:-$MONGODB_DB_NAME_DEFAULT}"

#check folder file
if [ ! -d "${BACKUP_PATH}" ]; then
        echo "Backup Directory does exist."
        mkdir -p "${BACKUP_PATH}"
        echo "${BACKUP_PATH} is created."
fi

#check log file
if [ ! -d "${BACKUP_LOG_PATH}" ]; then
        echo "Backup Log File does exist."
        touch "${BACKUP_LOG_PATH}"
        echo "${BACKUP_LOG_PATH} is created."
fi

# #backup rapro file
# find /home/pig/container/rapro-bk/rapro_*.zip -type f -mtime +14 -delete || true
# cd /home/pig/container || exit
# if zip -r "/home/pig/container/rapro-bk/rapro_file-$(date +"%Y-%m-%d").zip" rapro/; then
#         echo "rapro file backup Success $(date +%Y-%m-%d) $(date +%H:%M:%S)" >> "${log_file}"

# else

#         echo "rapro file backup Failed $(date +%Y-%m-%d) $(date +%H:%M:%S)" >> "${log_file}"
# fi
# # cd - || exit

# #backup db
cd "${BACKUP_PATH}" || exit
docker exec -i mongo /usr/bin/mongodump --usernameN "${MONGODB_USER}" --password "${MONGODB_PWD}" --authenticationDatabase admin --db "${MONGODB_DB_NAME}" --out /dump

if zip -r "${BACKUP_PATH}/${MONGODB_DB_NAME}_db-$(date +"%Y-%m-%d").zip" "dump/${MONGODB_DB_NAME}"; then
        echo "rapro db backup Success $(date +%Y-%m-%d) $(date +%H:%M:%S)" >>"${BACKUP_LOG_PATH}"
else
        echo "rapro db backup Failed $(date +%Y-%m-%d) $(date +%H:%M:%S)" >>"${BACKUP_LOG_PATH}"
fi
