#!/sbin/busybox sh

b="/sbin/busybox"

# Remount system RW
    /sbin/ext/busybox mount -o remount,rw /system
    /sbin/ext/busybox mount -t rootfs -o remount,rw rootfs

# Free some space
    toolbox rm /system/app/MobileODINFlasher.apk
    /sbin/ext/busybox cp /system/app/Maps.apk /Maps.tmp
    toolbox rm /system/app/Maps.apk
	$b cp /system/app/GMS_Maps.apk /GMS_Maps.tmp
	$b rm /system/app/GMS_Maps.apk
	$b cp /system/app/YouTube.apk /YouTube.tmp
	$b rm /system/app/YouTube.apk

# ensure /system/xbin exists
    toolbox mkdir /system/xbin
    toolbox chmod 755 /system/xbin

# su
    toolbox rm /system/bin/su
    toolbox rm /system/xbin/su
    toolbox cat /res/misc/su > /system/xbin/su
    toolbox chown 0.0 /system/xbin/su
    toolbox chmod 6755 /system/xbin/su

# Superuser
    toolbox rm /system/app/Superuser.apk
    toolbox rm /data/app/Superuser.apk
    /sbin/ext/busybox dd if=/dev/block/mmcblk0p5 of=/system/app/Superuser.apk skip=7000000 seek=0 bs=1 count=570342
    toolbox chown 0.0 /system/app/Superuser.apk
    toolbox chmod 644 /system/app/Superuser.apk

# CWM Manager
    toolbox rm /system/app/CWMManager.apk
    toolbox rm /data/dalvik-cache/*CWMManager.apk*
    toolbox rm /data/app/eu.chainfire.cfroot.cwmmanager*.apk

    /sbin/ext/busybox dd if=/dev/block/mmcblk0p5 of=/system/app/CWMManager.apk skip=6500000 seek=0 bs=1 count=331042
    toolbox chown 0.0 /system/app/CWMManager.apk
    toolbox chmod 644 /system/app/CWMManager.apk

boot_extract()
{
	eval $(/sbin/read_boot_headers /dev/block/mmcblk0p5)
	load_offset=$boot_offset
	load_len=$boot_len
	$b dd bs=512 if=/dev/block/mmcblk0p5 skip=$load_offset count=$load_len | $b xzcat | $b tar x
	payload=1
}

installs()
{
#	Checking Superuser installed
#	if [ ! -f /system/bin/su ]; then
#		[ -z $payload ] && boot_extract
#		rm /system/bin/su
#		rm /system/xbin/su
#		cp /cache/misc/su /system/bin/su
#		chown 0.0 /system/bin/su
#		chmod 6755 /system/bin/su
#		ln -s /system/bin/su /system/xbin/su
#		rm /system/app/*uper?ser.apk
#		rm /data/app/*uper?ser.apk
#		rm /data/dalvik-cache/*uper?ser.apk*
#		zcat /cache/misc/Superuser.apk.gz > /system/app/Superuser.apk
#		chown 0.0 /system/app/Superuser.apk
#		chmod 644 /system/app/Superuser.apk
#	fi

#	Checking if cwmmanager is installed
#	if [ ! -f /system/app/CWMManager.apk ];
#	then
#		[ -z $payload ] && boot_extract
#		rm /system/app/CWMManager.apk
#		rm /data/dalvik-cache/*CWMManager.apk*
#		rm /data/app/eu.chainfire.cfroot.cwmmanager*.apk
#		zcat /cache/misc/CWMManager.apk.gz > /system/app/CWMManager.apk
#		chown 0.0 /system/app/CWMManager.apk
#		chmod 644 /system/app/CWMManager.apk
#	fi

#	Install RomManager
	$b rm /system/app/com.koushikdutta.rommanager*.apk
	$b rm /system/app/RomManager.apk
	$b rm /data/dalvik-cache/*com.koushikdutta.rommanager*
	$b rm /data/app/com.koushikdutta.rommanager*.apk
	$b zcat /cache/misc/RomManager.apk.gz > /system/app/RomManager.apk
	$b chown 0.0 /system/app/RomManager.apk
	$b chmod 644 /system/app/RomManager.apk
}

# Restore tmp files if possible
    /sbin/ext/busybox cp /Maps.tmp /system/app/Maps.apk
    toolbox chown 0.0 /system/app/Maps.apk
    toolbox chmod 644 /system/app/Maps.apk
    toolbox rm /Maps.tmp

# Once be enough
    toolbox mkdir /system/cfroot
    toolbox chmod 755 /system/cfroot
    toolbox rm /data/cfroot/*
    toolbox rmdir /data/cfroot
    toolbox rm /system/cfroot/*
    echo 1 > /system/cfroot/release-124-LPG- 

# Remount system RO
    /sbin/ext/busybox mount -t rootfs -o remount,ro rootfs
    /sbin/ext/busybox mount -o remount,ro /system
