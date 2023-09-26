Raspberry Pi Salt
=================
This project is a set of salt states and pillar configuration I use to set up my Raspberry
Pi cluster. All of these start from a base [raspbian image](https://www.raspberrypi.org/downloads/raspbian/).

## Installing Salt on instances
This codebase assumes there is a running salt cluster of raspberry pis somewhere that you can
interface with. In order to get salt installed in the first place, you can use... salt.
salt-ssh to be exact. You'll have to use some commands in my other code base
[Raspberry Pi Inital Setup Salt](https://github.com/norwoodj/rpi-salt-initial-setup).

## Running salt states
After you've set up the instances, you're going to ssh into the master, mine's called:
`rp4-sma-mon-rmq-000` or Raspberry Pi 4 - Salt Master - Monitoring - Rabbitmq - The first one of this type.

```
ssh rp4-sma-mon-rmq-000
sudo salt "*" state.show_top
```

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
