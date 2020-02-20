# Backup of root directory
# Excludes system directories that are populated at boot
# Excludes filesystems that are backed up separately (scratch)
# Excludes filesystems that are backup destinations (datastore)
# If you add a new filesystem, remember to add it here

sudo rsync -aAXvP --delete --one-file-system --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found","/scratch/*","/datastore/*"} / /datastore/mirror/fig
