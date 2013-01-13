#!/sbin/busybox sh

# defines init.d and customboot.sh files location
# enables init.d & customboot.sh

if /sbin/busybox [ -d /system/etc/init.d ]; then
  /sbin/busybox run-parts /system/etc/init.d
fi;

if /sbin/busybox [ -f /system/bin/customboot.sh ]; then
  /sbin/busybox sh /system/bin/customboot.sh;
fi;

if /sbin/busybox [ -f /system/xbin/customboot.sh ]; then
  /sbin/busybox sh /system/xbin/customboot.sh
fi;

if /sbin/busybox [ -f /data/local/customboot.sh ]; then
  /sbin/busybox sh /data/local/customboot.sh
fi;
