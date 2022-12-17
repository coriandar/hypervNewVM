## UbuntuServer
    sudo timedatectl set-timezone Pacific/Auckland
    sudo apt update -y && sudo apt upgrade -y
    sudo apt install -y git neofetch xorg i3 cifs-utils ncdu curl

    192.168.1.0/24
    192.168.1.xx

## i3
    sudo vim /etc/i3status.conf
    sudo vim ~/.config/i3/config
        monospace 12
        i3-dmenu-desktop
        position top

## SetResolution
    xrandr
    cvt 2560 1440
    sudo vim /etc/X11/xorg.conf

    Section "Monitor"
        Identifier "Virtual-1"
        Modeline "2560x1440" 312.25 2560 2752 3024 3488 1440 1443 1448 1493 -hsync +vsync
        Option "PreferredMode" "2560x1440"
    EndSection

## Brave
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
    sudo apt update -y
    sudo apt install brave-browser -y
    
## Nvim
    https://neovim.io/doc/user/quickref.html#option-list
    ~/.config/nvim
    :Ex

## Plex
    cp /usr/lib/plexmediaserver/Resources/Plug-ins-*/WebClient.bundle/Contents/Resources/js/main-*
        secondsleft:1

## Eclipse
    usr/share/applications
    ~/.local/share/applications/eclipse.desktop
    Exec=/usr/share/eclipse/eclipse

## External Wifi Fix
    vEthernet > 192.168.1.xx
    vEthernet > Disable Large Send Offload > Restart Host   
    rxtxoff.sh
        #!/bin.bash
        ethtool --offload eth0  rx off
        ethtool --offload eth0  tx off

    sudo chmod +x /usr/local/sbin/rxtxoff.sh
    sudo nano /etc/systemd/system/rxtxoff.service
        [Service]
        ExecStart=/bin/bash	/usr/local/sbin/rxtxoff.sh

        [Install]
        WantedBy=multi-user.target

    sudo systemctl daemon-reload
    sudo systemctl enable rxtxoff.service
    sudo systemctl start rxtxoff.service
