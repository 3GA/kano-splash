#!/bin/bash
#
#  kano-launcher common functions for all scripts that start Kanux desktop icons
#

lockfile=/tmp/kano-launcher.lock

function cleanup {
    if [ -f $lockfile ]; then
        rm $lockfile
    fi
}
trap cleanup EXIT

function is_app_running()
{
    # usage: mywid=""; is_app_running "mywndow" mywid
    # retuns 1 if running or 0 if not running, wid in $2

    wdata=`xwininfo -root -tree | grep "$1"`
    rc=$?
    if [ $rc -eq 0 ]; then
        wid=`echo $wdata | awk '{print $1}'`
        eval "$2=\"$wid\""
        return 1
    else
        return 0
    fi
}

function restart_daemons()
{
    # Launch Minecraft python server
    killall -q python
    killall -q minecraft-pi
    killall -q midori

    # This python app will listen for F8 keypress
    # and give focus to Make Minecraft
    python /usr/sbin/kevents.py 1 &
}

function protect_reentrancy
{
    #
    # if we are running, give focus and exit
    #
    if [ -f $lockfile ]; then
	echo "$APPNAME2 is starting."
	exit 0
    else
	touch $lockfile
    fi
}
