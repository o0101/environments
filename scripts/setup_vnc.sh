#!/bin/bash

me=$(whoami)
sudo apt install xfce4 xfce4-goodies tightvncserver
sudo systemctl clean vncserver
read -p "Set up a password now"
vncserver
vncserver -kill :1
grep -qxF "startxfce4 &" $HOME/.vnc/xstartup || echo "startxfce4 &" >> $HOME/.vnc/xstartup
echo "
#!/bin/bash
xrdb $HOME/.Xresources
autocutsel -fork
vncconfig -iconic &
vncconfig -nowin &
startxfce4 &
" > $HOME/.vnc/xstartup
chmod +x $HOME/.vnc/xstartup
sudo tee <<EOF  /etc/systemd/system/vncserver.service >/dev/null
[Unit]
Description=Remote desktop service (VNC)
After=syslog.target network.target

[Service]
Type=forking
User=$USER

# Clean any existing files in /tmp/.X11-unix environment
ExecStartPre=/bin/sh -c '/usr/bin/vncserver -kill :1 > /dev/null 2>&1 || :'
ExecStart=/usr/bin/vncserver -geometry 1392x750 -depth 16 -dpi 120 -localhost :1 
ExecStop=/usr/bin/vncserver -kill :1

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable --now vncserver


