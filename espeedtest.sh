#!/bin/sh

###############################################################################
# espeedtest.sh
# espeedtest.sh is a speedtest script to test your network bandwidth. If you
# are unable to run this script with ./espeedtest.sh then you probably need to
# set it's permissions. You can do this by typing the following:
#
# chmod 755 espeedtest.sh
#
# after this has been done, you can type ./espeedtest.sh to run the script.
#
###############################################################################

DL_SERVER=download.speedtest.com.hk
UL_SERVER=upload.speedtest.com.hk
USER=anonymous
PASS=anonymous
FILE=100MBvideo.zip # 100MBvideo.zip/700MBvideo.zip
OS=`uname`;

if [ "$OS" = "FreeBSD" ]; then
    FTP_PATH=/usr/local/bin/ftp
else
    FTP_PATH=/usr/bin/ftp
fi

if [ ! -e $FTP_PATH ]; then
    echo "Cannot find ftp. Please install ftp first";
    exit 1;
fi

REDHAT_RELEASE=/etc/redhat-release
DEBIAN_VERSION=/etc/debian_version

if [ -e $DEBIAN_VERSION ]; then
    OS=debian
    RESULT_KEYWORD=kB
else
    OS=linux
    RESULT_KEYWORD=Kbyte
fi

function download {
    $FTP_PATH -vn $DL_SERVER << DOWNLOAD
    user $USER $PASS
    get $FILE
    bye
DOWNLOAD
}

function upload {
    $FTP_PATH -vn $UL_SERVER << UPLOAD
    user $USER $PASS
    put $FILE
    bye
UPLOAD
}

DL_SPEED=$(download | grep $RESULT_KEYWORD | sed 's/^.*(//g' | sed "s/ $RESULT_KEYWORD.*//g")
UL_SPEED=$(upload | grep $RESULT_KEYWORD | sed 's/^.*(//g' | sed "s/ $RESULT_KEYWORD.*//g")

/bin/rm -rf $FILE

# Submit the result to Google Form via curl
# curl 'https://docs.google.com/forms/d/<form_id>/formResponse' -H 'user-agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.86 Safari/537.36' -H 'content-type: application/x-www-form-urlencoded' --data 'entry.<q_id>='$DL_SPEED'&entry.<q_id>='$UL_SPEED --compressed > /dev/null 2>&1

echo "Download Speed : $DL_SPEED byte/s"
echo "Upload Speed : $UL_SPEED byte/s"
