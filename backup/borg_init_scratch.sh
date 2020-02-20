#!/bin/sh

# Initialize archive for backup of scratch

borg init --encryption=none /datastore/snapshots/scratch
