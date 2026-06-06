# Backup Automation Scripts

Collection of backup automation scripts.

## Current Scripts

### postgres_daily_backup.sh

Features:

* PostgreSQL database backup using `pg_dump`
* OneDrive upload using `rclone`
* Email notifications
* Configurable retention period
* Configuration stored in `.env`

## Requirements

* PostgreSQL client tools (`pg_dump`)
* rclone
* mailutils
* Linux cron

## Environment Variables

Create a `.env` file in the same directory as the script.

Required variables:

```env
DATABASE_NAME=
BACKUP_DIR=
ONEDRIVE_REMOTE=
ONEDRIVE_FOLDER=
ONEDRIVE_LINK=
EMAILS=
RETENTION_DAYS=
```

## Cron Example

```cron
SCRIPT_DIR=

59 15 * * * $SCRIPT_DIR/postgres_daily_backup.sh
```

## Backup Flow

1. Create PostgreSQL dump
2. Upload backup to OneDrive
3. Remove local backups older than configured retention period
4. Send email notification
