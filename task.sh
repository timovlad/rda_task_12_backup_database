#!/bin/bash

DB_USER="${DB_USER}"
DB_PASSWORD="${DB_PASSWORD}"

SOURCE_DB="ShopDB"
BACKUP_DB="ShopDBReserve"
DEV_DB="ShopDBDevelopment"

BACKUP_DIR="/var/backups/mysql"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

mkdir -p ${BACKUP_DIR}
mysqldump -u "${DB_USER}" -p"${DB_PASSWORD}" --databases ${SOURCE_DB} > ${BACKUP_DIR}/${SOURCE_DB}_backup_${TIMESTAMP}.sql

mysql -u "${DB_USER}" -p"${DB_PASSWORD}" ${BACKUP_DB} < ${BACKUP_DIR}/${SOURCE_DB}_backup_${TIMESTAMP}.sql

mysqldump -u "${DB_USER}" -p"${DB_PASSWORD}" --no-create-info ${SOURCE_DB} > ${BACKUP_DIR}/${SOURCE_DB}_data_${TIMESTAMP}.sql

mysql -u "${DB_USER}" -p"${DB_PASSWORD}" ${DEV_DB} < ${BACKUP_DIR}/${SOURCE_DB}_data_${TIMESTAMP}.sql
