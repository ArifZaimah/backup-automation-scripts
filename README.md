# Backup Automation Scripts

Collection of backup automation scripts for Linux servers.

## Available Scripts

| Script                   | Description                                            |
| ------------------------ | ------------------------------------------------------ |
| postgres_daily_backup.sh | PostgreSQL backup, OneDrive upload, email notification |

## Documentation

* [PostgreSQL Daily Backup](README-POSTGRES_DAILY_BACKUP.md)

## Features

* Automated backups
* Cloud storage integration
* Email notifications
* Configurable through environment variables
* Cron-friendly automation

## Repository Structure

```text
backup-automation-scripts/
├── postgres_daily_backup.sh
├── README.md
├── README-POSTGRES_DAILY_BACKUP.md
└── .gitignore
```

## Future Plans

Additional backup automation scripts may be added in the future, including:

* Database backups
* Application configuration backups
* Server configuration backups
* Infrastructure automation scripts
