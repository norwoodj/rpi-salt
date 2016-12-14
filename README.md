Raspberry Pi Salt
=================

This project is a set of salt states and pillar configuration I use to set up my Raspberry
Pi cluster. All of these start from a base [hypriot image](todo).

## Installing Salt on instances
This codebase assumes there is a running salt cluster of raspberry pis somewhere that you can
interface with. In order to get salt installed in the first place, you can use... salt.
salt-ssh to be exact. You'll have to use some commands in my other code base
[Raspberry Pi Inital Setup Salt](https://github.com/norwoodj/rpi-salt-initial-setup).

## Running salt states
After you've set up the instances, you're going to ssh into the master, mine's called:
`rp3-sma-kbw-000` or Raspberry Pi 3 - Salt Master - Kubernetes Worker - The first one of this type.

```
ssh rp3-sma-kbw-000

sudo salt '*kbm*' state.apply kubernetes-master pillar='{"kubernetes": {"token": "5a3d09.8b2d382a36c0e0a7"}}'
sudo salt '*kbw*' state.apply kubernetes-worker pillar='{"kubernetes": {"token": "5a3d09.8b2d382a36c0e0a7"}}'
```

Obviously don't actually use this token.
