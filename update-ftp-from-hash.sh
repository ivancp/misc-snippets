#!/bin/bash
# ------------------------------------------------------------------
# [Author] Ivan Cachicatari
#          
# Script to upload a repository from desired commit hash 
# to an FTP Server using lftp commanda
#
# Receive one parameter: the commit hash
#    
# ------------------------------------------------------------------

USER="user"
PASS="password"
REMOTEDIR="/public_html"
HOST="ip_or_hostname"
TMPFILE="/tmp/cmd.lftp"

#Clearing tmp file
echo "" > $TMPFILE

#creating lftp commands from git diff
for f in `git diff --name-only $1 HEAD`;
do
    echo "cd" `dirname $REMOTEDIR/$f` >> $TMPFILE
    echo "put" $f >> $TMPFILE
done

#executing commands on FTP server
lftp -u $USER,$PASS $HOST << EOF
`cat $TMPFILE`
bye
EOF
