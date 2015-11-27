#!/bin/sh

DL_SPEED=$(./download.sh | grep '[0-9] kB/s' | sed 's/^.*(//g' | sed 's/ *kB.*//g')
UL_SPEED-$(./upload.sh | grep '[0-9] kB/s' | sed 's/^.*(//g' | sed 's/ *kB.*//g')
