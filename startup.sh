#!/bin/bash

#This script is ran by systemd in
#/etc/systemd/system/startup_project.service
#service contents:
#[Unit]
#Description=Reboot message systemd service.
#
#[Service]
#Type=simple
#ExecStart=/bin/bash /home/pi/startup.sh
#
#[Install]
#WantedBy=multi-user.target
#service contents END

#After the service file is created
#RUN:
#chmod 644 /etc/systemd/system/startup_project.service
#systemctl enable startup_project.service

FILE=/etc/systemd/system/startup_project.service
if [ -f "$FILE" ]; then
    echo "$FILE exists."
else 
    echo "$FILE does not exist."
    read -p "Do you want to install file?(y/n): " rp
    if [ $rp == "y" ];then
       echo "Vann3299" | sudo -S echo "Login"
       sudo echo "
[Unit]
Description=Reboot message systemd service.

[Service]
Type=simple
ExecStart=/bin/bash /home/pi/startup.sh

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/startup_project.service
             chmod 644 /etc/systemd/system/startup_project.service
             systemctl enable startup_project.service
             else
                exit
             fi
fi

#The while loop will keep trying to open the browser until successful
EXIT=1
while [ $EXIT -eq 1 ];do
sleep 5
sudo -u pi DISPLAY=:"0.0" chromium-browser --no-sandbox http://calendarprojects.com/MeetingSchedule
EXIT=$?
done
