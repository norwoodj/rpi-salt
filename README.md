Raspberry Pi Salt
=================
This project is a set of salt states and pillar configuration I use to set up my Raspberry
Pi on which I run all of my personal websites and associated supporting software.

At present, I use a Raspberry Pi 5 with 8GB RAM, on which I run an Ubuntu Server 24.04.1 LTS
image. I create the boot image using [rpi-imager](https://ubuntu.com/blog/how-to-install-ubuntu-with-the-new-raspberry-pi-imager).

## Setting up the root filesystem on an external harddrive
The setup described here will have your boot partition on an SD card
(that you write with `rpi-imager`), and your root filesystem on some external hard
drive.

First thing to do is format whatever external drive you'll use as an ext4 filesystem.
Then, use `e2label` to label the partition you've formatted:
```
sudo e2label /dev/<partition-name> <partition-label>
```

Now, plug the external drive and the SD card created with `rpi-imager` to your
raspberry pi. Boot the raspberry pi from the SD card as normal. Once it's started and you've
SSHed in, edit the `/boot/firmware/cmdline.txt` file like so:
```
+console=serial0,115200 dwc_otg.lpm_enable=0 console=tty1 root=LABEL=<partition-label> rootfstype=ext4 rootwait fixrtc quiet splash
-console=serial0,115200 dwc_otg.lpm_enable=0 console=tty1 root=LABEL=writable rootfstype=ext4 rootwait fixrtc quiet splash
```

The old label may differ, but this tells the bootloader to use the external
partition you've formatted as the root filesystem.

Next backup and create a new version of `/etc/fstab` file like so:
```
sudo cp /etc/fstab /etc/fstab.old
sudo cp /etc/fstab /etc/fstab.new
```

Then update the new `/etc/fstab.new` file to tell ubuntu to mount your external
partition at `/`:
```
+LABEL=<partition-label>       /       ext4    discard,errors=remount-ro       0 1
-LABEL=writable       /       ext4    discard,errors=remount-ro       0 1
LABEL=system-boot       /boot/firmware  vfat    defaults        0       1
```

Now we need to copy over all the OS files to your external partition:
```
sudo mount /dev/<partition-name> /mnt
sudo rsync -axv / /mnt
```

Finally, update the `/mnt/etc/fstab` file to be the new version, which will mount
the external partition as the root filesystem, once ubuntu is booted:
```
sudo cp /mnt/etc/fstab.new /mnt/etc/fstab
```

You should now be able to reboot, and then see your external drive mounted as the
root filesystem:
```
NAME        FSTYPE   FSVER LABEL                     UUID                                 FSAVAIL FSUSE% MOUNTPOINTS
...
sda                                                                                                      
├─sda1      vfat     FAT32 EFI                       67E3-17ED                                           
└─sda2      ext4     1.0   <partition-label>         562cb9fe-9ec3-416f-b36a-996b0b5214e4  430.5G     1% /
mmcblk0                                                                                                  
├─mmcblk0p1 vfat     FAT32 system-boot               F04B-5543                             104.1M    59% /boot/firmware
└─mmcblk0p2 ext4     1.0   writable                  877a65cf-888e-47c6-b4e0-ec5c52c54be8
```

## Running salt states
Now, you're ready to being actually running the salt states to setup the raspberry
pi. SSH into the instance you want to configure, clone this repository, and
bootstrap it:
```
git clone https://github.com/norwoodj/rpi-salt.git
cd rpi-salt
sudo ./bootstrap.sh
```

This will install salt and create the symlinks to run these states as a salt-masterless
setup.

## Generating the tunnels
* Create the tunnel. I use the instance name (0p0 or 255p0) for the tunnel name
```
cloudflared tunnel create <tunnel_name>
```

This will yield a credentials file stored at `$HOME/.cloudflared/<tunnel_id>.json`.
You will need to pull the tunnel_secret from this file to fill out `secrets.sls`

To create the routes to that tunnel
```
# DNS routes
cloudflared tunnel route dns <tunnel_name> bolas.jmn23.com
cloudflared tunnel route dns <tunnel_name> hashbash.jmn23.com
cloudflared tunnel route dns <tunnel_name> stupidchess.jmn23.com

# Private Network
cloudflared tunnel route ip add <node_ip>/32 <tunnel_name>
```
