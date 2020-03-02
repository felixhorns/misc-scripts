# Before running this, you need to configure rclone with your box remote.
# This can be done by running "rclone configure" and following the prompts.
# Our remote is named "box".
# This script syncs snapshots to box.
# This should be run with sudo, so that archives owned by root are accessible.
# Config file must be given because otherwise the root config file is used by default, which does not have the remote configured.
rclone sync /datastore/snapshots/ box:/datastore/snapshots/ --copy-links --config /home/felix/.config/rclone/rclone.conf --log-level INFO
