#!/sbin/busybox sh

mkdir /data/.jeboo
chmod 777 /data/.jeboo

#mdnie sharpness tweak
if /sbin/busybox [ "`/sbin/busybox grep 1 /data/.jeboo/mdnie_tweak`" ]; then
. /sbin/ext/mdnie-sharpness-tweak.sh
fi

