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

#The while loop will keep trying to open the browser until successful
EXIT=1
while [ $EXIT -eq 1 ];do
sleep 5
sudo -u pi DISPLAY=:"0.0" chromium-browser --no-sandbox http://calendarprojects.com/MeetingSchedule
EXIT=$?
done
