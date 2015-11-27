#!/bin/sh

DL_SPEED=$(./download.sh | grep '[0-9] kB/s' | sed 's/^.*(//g' | sed 's/ *kB.*//g')
UL_SPEED=$(./upload.sh | grep '[0-9] kB/s' | sed 's/^.*(//g' | sed 's/ *kB.*//g')

curl 'https://docs.google.com/forms/d/<form_id>/formResponse' -H 'user-agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.86 Safari/537.36' -H 'content-type: application/x-www-form-urlencoded' --data 'entry.<q_id>='$DL_SPEED'&entry.<q_id>='$UL_SPEED --compressed > /dev/null 2>&1
