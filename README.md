Trunk Recorder Pro call upload script for Ubuntu will upload the calls to your web page, 
the html for your website code is provided also see it working at https://mymbnet.net/scanner.html
Run this shell script change USER@SSH-SERVER-ip-ADDRESS in the file for your server must have password ssh for this script
Go into Trunk Recorder pro plugins and install upload script 
Put this in the script line /usr/local/bin/upload_call.sh and turn on


This script will 
Automatically upload calls and data to your website 
1. Delete any audio or JSON files older than 24 hours
2. 2. Rebuild calls.json from remaining calls (newest first, up to 200)


In the html change YOUR-WEBSITE and YOUR-CITY 3 places and modify the html code to match your website or use AI to modify it.


<img width="1706" height="1159" alt="image" src="https://github.com/user-attachments/assets/9df2ff6a-78d0-46ff-8b0e-83945f93ea6a" />

<img width="2160" height="1234" alt="image" src="https://github.com/user-attachments/assets/80a05a0b-6cd4-422e-a928-b42444e79c06" />
