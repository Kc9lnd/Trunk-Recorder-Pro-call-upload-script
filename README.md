Trunk Recorder Pro call upload script for Ubuntu will upload the calls to your web page, 
the html for your website code is provided also see it working at https://mymbnet.net/scanner.html
Run this shell script change USER@SSH-SERVER-ip-ADDRESS in the file for your server must have password ssh for this script
Go into Trunk Recorder pro plugins and install upload script 
Put this in the script line /usr/local/bin/upload_call.sh and turn on


This script will 
Automatically upload calls and data to your website 
1. Delete any audio or JSON files older than 24 hours
2. 2. Rebuild calls.json from remaining calls (newest first, up to 200)
