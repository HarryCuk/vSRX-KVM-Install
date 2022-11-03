#!/bin/bash

echo -n "Mounting vSRX image..."
# Copy and mount vSRX image.
cp junos-vsrx3-x86-64-22.3R1.11.qcow2 /mnt/vSrxTest_SRIOV.qcow2
sleep 2

echo -n "Creating virtual machine../"
# vSRX virtual machine installation command.
  # --name <name of the Virtual Machine>.
  # --ram <define the amount of RAM to allocate to the VM>.
  # --cpu <define the CPU model>. See cpu_map.xml file for full list, or use host to automatically use the host CPU.
  # --vcpus <define the number of vCPU's to allocate to the VM.>
  # --arch <define the compute architecture>. x86_64 is the most common. If removed the host CPU architecture will be used.
  # --disk <define the path to the vSRX image> size <HDD size>, bus<Storage bus>, format<type of VM file>
  # --os-variant<specify the operating system of the GUEST.>
  # --import <specify the networks to be attached to the VM.>
virt-install --name vSrxTest_SRIOV \
 --memory 4096 \
 --cpu host \
 --vcpus=2 \
 --arch=x86_64 \
 --disk /mnt/vSrxTest_SRIOV.qcow2,size=16,device=disk,bus=ide,format=qcow2 --import \
 --os-type linux \
 --os-variant rhel7.0 \
 --network=network:default,model=virtio \
 --host-device=pci_0000_06_10_1 \
 --host-device=pci_0000_08_10_0 \
 --host-device=pci_0000_08_10_1 \

exit 1