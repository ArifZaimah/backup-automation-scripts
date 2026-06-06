#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

set -a
source "$SCRIPT_DIR/.env"
set +a

DATE=$(date +%F)
HOSTNAME=$(hostname)

BACKUP_FILE="$BACKUP_DIR/${DATABASE_NAME}_$DATE.sql"

mkdir -p "$BACKUP_DIR"

# Create PostgreSQL backup
if sudo -u postgres pg_dump "$DATABASE_NAME" > "$BACKUP_FILE"; then

    # Upload to OneDrive
    if rclone copy "$BACKUP_FILE" "$ONEDRIVE_REMOTE:$ONEDRIVE_FOLDER"; then

        # Delete local backups older than configured retention period
        find "$BACKUP_DIR" \
            -name "*.sql" \
            -mtime +"$RETENTION_DAYS" \
            -delete

        echo "
PostgreSQL backup completed successfully.

Server: $HOSTNAME
Database: $DATABASE_NAME
Backup File: $BACKUP_FILE
Date: $(date)

OneDrive Upload: SUCCESS

You may check the backup stored here : $ONEDRIVE_LINK
" | mail -s "PostgreSQL Backup SUCCESS" $EMAILS

    else

        echo "
PostgreSQL backup created but OneDrive upload failed.

Server: $HOSTNAME
Database: $DATABASE_NAME
Backup File: $BACKUP_FILE
Date: $(date)

You may check the backup stored here : $ONEDRIVE_LINK
" | mail -s "PostgreSQL Backup FAILED (Upload Error)" $EMAILS

        exit 1
    fi

else

    echo "
PostgreSQL backup failed.

Server: $HOSTNAME
Database: $DATABASE_NAME
Date: $(date)

You may check the backup stored here : $ONEDRIVE_LINK
" | mail -s "PostgreSQL Backup FAILED" $EMAILS

    exit 1
fi
