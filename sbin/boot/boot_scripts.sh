#!/sbin/busybox sh

# extract busybox to use instead of recovery busybox +/- install in bin/xbin
# /sbin/busybox sh /sbin/boot/busybox.sh

# set custom kernel properties to check kernel version if needed later
/sbin/busybox sh /sbin/boot/properties.sh

# for further tasks like adding root, extract busybox, Rom Manager...
# /sbin/busybox sh /sbin/boot/install.sh

# starts init.d and customboot.sh scripts
/sbin/busybox sh /sbin/boot/init-scripts.sh