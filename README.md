# Backup Script
1. Prepare an S3 bucket to hold the backups
2. Install `restic`, `sudo` and `cron` (or distribution equivalent) on the backup computer
3. Create a new user on the server where you will perform the backups and disable login for the user
4. Copy the scripts `env.sh` and `restic.sh` to the new users home directory
4. Adjust the values in the files (which files to backup and retention in `restic.sh`, keys in `env.sh`)
5. Adjust the permissions on the files, especially `env.sh` as it contains sensitive keys (i.E. `chmod 600 ./env.sh`)
6. Change sudo config by running `visudo` as root:
    - Allow the user to run `restic` (tool) as root without entering password: `username ALL=(ALL) NOPASSWD: /usr/bin/restic` (adjust path to restic binary if necessary)
    - Change the configured environment variables to be passed through to sudo by adding or adjusting the following line: `Defaults        env_keep += "RESTIC_REPOSITORY AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY RESTIC_PASSWORD"`
7. Add a cron job with the backup user (i.E. `crontab -e`): `0  2   *   *   wed,sun /home/username/restic.sh 2>&1 | /usr/bin/logger -t restic_backup` (adjust cron string)
8. Make sure to enable the cron system service
