# Before running this, you need to configure rclone with your box remote.
# This can be done by running "rclone configure" and following the prompts.
# Our remote is named "box".
# This script syncs snapshots to box.
# This should be run with sudo, so that archives owned by root are accessible.
rclone sync /datastore/snapshots/ box:/datastore/snapshots/ --copy-links --log-file ~/backup_scripts/log/rclone_snapshots_box.log --log-level INFO
