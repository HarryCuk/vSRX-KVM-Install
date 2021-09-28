#!/bin/bash
start=`date +%s`


echo -n "Please enter your Linux username: "
read username
sleep 2

echo "Fetching latest packages..."
sleep 1
# Update latest packages and install latest versions of packages
apt-get update # Retrieve latest package lists
echo "Checking installed packages for updates (Optional)"
sleep 1
apt-get upgrade # Update pre-installed packages
sleep 1
echo "Installing CPU-Checker package..."
apt install cpu-checker -y
sleep 1

echo "Checking if device meets KVM installation requirements..."
sleep 2.5
if kvm-ok | grep -q 'KVM acceleration can be used'; then
    echo "KVM can be used - continuing"
    sleep 5
else
    echo "KVM cannot run on this device - exiting"
    sleep 5
    exit
fi    

echo "Installing KVM and required packages..."
# Install KVM and other required packages
apt-get install qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils

# Prompt if GUI Virt Manager is required
while true; do
    read -p "Do you wish to install the GUI Virt Manager [Y/N?]" yn
    case $yn in
    [Yy]* ) apt-get install virt-manager -y; break;;
    [Nn]* ) break;;
    * ) echo "Please answer yes or no.";;
    esac
done

# echo "KVM Installed"
sleep 2

echo "Adding user to groups"
usermod -a -G kvm $username
usermod -a -G libvirt $username

if groups $username | grep -q 'kvm libvirt'; then
    echo "Required groups added successfully"
    sleep 5
else
    echo "Failed to add required groups to username:" $username 
    echo "Please ensure you have entered the NON-ROOT username correctly."
    sleep 5
    exit
fi    

echo "Verifying KVM Install..."
if virsh list --all | grep -q 'Id'; then
    echo "KVM successfully installed!"
    sleep 5
else
    echo "KVM Installation failed, please check logs and try again."
    sleep 5
    exit
fi    


end=`date +%s`
runtime=$((end-start))
echo "End of script"
echo "Runtime:" $runtime "Seconds"
