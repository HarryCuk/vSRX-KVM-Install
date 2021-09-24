#!/bin/bash

echo -n "Please enter Linux username: "
read username
echo $username
sleep 5

if kvm-ok | grep -q 'KVM acceleration can be used'; then
    echo "KVM can be used - continuing"
    sleep 5
else
    echo "KVM cannot run on this device - exiting"
    sleep 5
    exit
fi    


# Update latest packages and install latest versions of packages
apt-get update # Retrieve latest package lists
apt-get upgrade # Update pre-installed packages

# Install KVM and other required packages
#apt-get install qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils

# Prompt if GUI Virt Manager is required
while true; do
    read -p "Do you wish to install GUI Virt Manager [Y/N?]" yn
    case $yn in
    [Yy]* ) apt-get install virt-manager; break;;
    [Nn]* ) break;;
    * ) echo "Please answer yes or no.";;
    esac
done

echo "Script End"