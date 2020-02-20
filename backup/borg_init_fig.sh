#!/bin/sh

# Initialize archive for backup of fig
# This should be run with sudo, because all future
# archives will be created with sudo (so that system files
# owned by root will be readable).

borg init --encryption=none /datastore/snapshots/fig
