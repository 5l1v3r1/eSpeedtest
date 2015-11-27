#!/bin/sh

UL_SERVER='upload.speedtest.com.hk'
USER='anonymous'
PASS='anonymous'
FILE='700MBvideo.zip'

ftp -vn $UL_SERVER << UPLOAD
user $USER $PASS
put $FILE
bye
UPLOAD

rm -rf $FILE
