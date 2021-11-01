#!/bin/bash

me=$(whoami)
sudo apt install xfce4 xfce4-goodies tightvncserver
read -p "Set up a password now"
vncserver
vncserver -kill :1
grep -qxF "startxfce4 &" $HOME/.vnc/xstartup || echo "startxfce4 &" >> $HOME/.vnc/xstartup
sudo tee <<EOF  /etc/systemd/system/vncserver.service >/dev/null
[Unit]
Description=TightVNC server
After=syslog.target network.target

[Service]
Type=forking
User=cris
Group=cris
WorkingDirectory=/home/cris
PIDFile=/home/cris/.vnc/%H:%i.pid
ExecStartPre=/bin/bash -c "/usr/bin/vncserver -kill :%i > /dev/null 2>&1 || :"
ExecStart=/usr/bin/vncserver -depth 24 -geometry 1390x750 -localhost :%i
ExecStop=/usr/bin/vncserver -kill :%i

[Install]
WantedBy=multi-user.target
EOF
sudo systemctl daemon-reload
sudo systemctl enable --now vncserver


