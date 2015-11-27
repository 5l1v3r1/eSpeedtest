#!/bin/sh

DL_SERVER='download.speedtest.com.hk'
USER='anonymous'
PASS='anonymous'
FILE='700MBvideo.zip'

ftp -vn $DL_SERVER << DOWNLOAD
user $USER $PASS
get $FILE
bye
DOWNLOAD
