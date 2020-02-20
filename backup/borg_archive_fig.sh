#!/bin/sh

# Create backup archive of fig's root directory

# Repository that we will write archive into
REPO="/datastore/snapshots/fig/"

# Setting the environment variable $HOME to find the home directory.
# This is necessary because Borg uses $HOME to find the home directory,
# and thus the cache directory (~/.cache/borg/[repo id]/), but
# $HOME is not set in the cron shell environment.
export HOME="/home/felix"
echo HOME = $HOME

# Setting this, so repo initialized by other users (e.g. root) is accessible
# This causes borg to not recognize existing files, so entire archive will
# be created from fig (with duplicates).
# export BORG_UNKNOWN_UNENCRYPTED_REPO_ACCESS_IS_OK='yes'

# some helpers and error handling:
info() { printf "\n%s %s\n\n" "$( date )" "$*" >&2; }
trap 'echo $( date ) Backup interrupted >&2; exit 2' INT TERM

info "Starting backup"

# Backup / from fig into an archive named after fig and the current date
borg create                                            \
     --verbose                                         \
     --list                                            \
     --filter AME                                      \
     --stats                                           \
     --one-file-system                                 \
     --exclude-caches                                  \
     --exclude '/dev'                                  \
     --exclude '/proc'                                 \
     --exclude '/sys'                                  \
     --exclude '/tmp'                                  \
     --exclude '/run'                                  \
     --exclude '/mnt'                                  \
     --exclude '/media'                                \
     --exclude '/lost+found'                           \
     --exclude '/scratch'                              \
     --exclude '/datastore'                            \
     --exclude '/home/*/.cache'                        \
     --compression auto,zlib,6                         \
     $REPO::fig-{now:%Y-%m-%d}                         \
     /                                                 \
     

backup_exit=$?

info "Pruning repository"

# Use the `prune` subcommand to maintain 7 daily, 4 weekly and 6 monthly archives.
borg prune                          \
    --list                          \
    --prefix 'fig-'                 \
    --show-rc                       \
    --keep-daily    7               \
    --keep-weekly   4               \
    --keep-monthly  3               \
    $REPO


prune_exit=$?

# use highest exit code as global exit code
global_exit=$(( backup_exit > prune_exit ? backup_exit : prune_exit ))

if [ ${global_exit} -eq 0 ]; then
    info "Backup and Prune finished successfully"
elif [ ${global_exit} -eq 1 ]; then
    info "Backup and/or Prune finished with warnings"
else
    info "Backup and/or Prune finished with errors"
fi
