#!/bin/bash

FULL=${1:-simple}

# Exit on error
set -e

# inform on disk space available
diskUsage=$(df -hT /home)
echo "Info: disk usage dedicated to database backups on s2laveyre:" 1>&2
echo "$diskUsage" 1>&2

echo "End of script file." 1>&2
