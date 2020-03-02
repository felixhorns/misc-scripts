# Example crontab file for backups
# Best to run as root via "sudo crontab -e".
#
# Tasks:
# Daily mirror
# Daily archive using borg
# Weekly check consistency of borg archives
# Weekly clone archives to box
#
# Edit this file to introduce tasks to be run by cron.
# 
# Each task to run has to be defined through a single line
# indicating with different fields when the task will be run
# and what command to run for the task
# 
# To define the time you can provide concrete values for
# minute (m), hour (h), day of month (dom), month (mon),
# and day of week (dow) or use '*' in these fields (for 'any').# 
# Notice that tasks will be started based on the cron's system
# daemon's notion of time and timezones.
# 
# Output of the crontab jobs (including errors) is sent through
# email to the user the crontab file belongs to (unless redirected).
# 
# For example, you can run a backup of all your user accounts
# at 5 a.m every week with:
# 0 5 * * 1 tar -zcf /var/backups/home.tgz /home/
# 
# For more information see the manual pages of crontab(5) and cron(8)
# 
# m h  dom mon dow   command

0 2 * * * /home/felix/backup_scripts/rsync_mirror_fig.sh > /home/felix/backup_scripts/log/rsync_mirror_fig.log 2>&1
30 2 * * * /home/felix/backup_scripts/rsync_mirror_scratch.sh > /home/felix/backup_scripts/log/rsync_mirror_scratch.log 2>&1
0 3 * * * /home/felix/backup_scripts/borg_archive_fig.sh 2>&1 | tee /home/felix/backup_scripts/log/borg_archive_fig-$(date +\%Y-\%m-\%d).log
30 3 * * * /home/felix/backup_scripts/borg_archive_scratch.sh 2>&1 | tee /home/felix/backup_scripts/log/borg_archive_scratch-$(date +\%Y-\%m-\%d).log
30 4 * * 0 /home/felix/backup_scripts/rclone_snapshots_box.sh > /home/felix/backup_scripts/log/rclone_snapshots_box.log 2>&1
30 4 * * 1 /home/felix/backup_scripts/borg_check_fig.sh > /home/felix/backup_scripts/log/borg_check_fig.log 2>&1
0 5 * * 1 /home/felix/backup_scripts/borg_check_scratch.sh > /home/felix/backup_scripts/log/borg_check_scratch.log 2>&1
