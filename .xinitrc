#!/bin/sh
#~/.xinitrc
#
# Executed by startx (run your window manager from here)
#

# disable beep
setterm -blength 0

#killall scim > /dev/null 2>&1
#export XMODIFIERS=@im=scim
#export GTK_IM_MODULE="scim"
#export QT_IM_MODULE="scim"
#env LC_ALL="zh_CN.UTF-8" scim -d & 

killall ibus > /dev/null 2>&1
export XMODIFIERS="@im=ibus"
export GTK_IM_MODULE="ibus"
export QT_IM_MODULE="xim"
ibus-daemon --xim &
#env LC_ALL="zh_CN.UTF-8" ibus-daemon  & 

xcompmgr -c -t-5 -l-5 -r4 -o.55 &
#xcompmgr -Ss -n -Cc -fF -I-10 -O-10 -D1 -t-3 -l-4 -r4 &
#xrdb ~/.Xresources &
xrdb ~/.Xdefaults &
xscreensaver -no-splash &

killall xhost > /dev/null 2>&1
(sleep 2 && xhost +) &
killall x11vnc > /dev/null 2>&1
(sleep 3 && x11vnc -forever -shared -rfbauth ~/.vnc/passwd)  &

# rox -filer
#killall rox > /dev/null 2>&1
#rox -p default &

# wallpaper
#eval `cat ~/.fehbg` &
feh --bg-scale ~/.wallpaper/edge.jpg &
#feh --bg-scale ~/.backgroup/Ladybug.jpg &

#killall conky  >  /dev/null 2>&1
#conky &
#killall gkrellm > /dev/null 2>&1
#gkrellm &

#killall tilda > /dev/null 2>&1
#tilda &

killall -s9  urxvtd > /dev/null 2>&1
urxvtd &

#simdock -b=/home/dingzi/.fluxbox/backgrounds/bg.jpg -y &
#killall fbpanel > /dev/null 2>&1
#fbpanel &
#bmpanel &
#pypanel &

#exec openbox 
#exec startfluxbox
#exec fvwm
#exec pekwm
#exec dwm
#exec xmonad
exec awesome

killall -s9  urxvtd > /dev/null 2>&1


#xrandr -s 1024x768
#xrandr -r 75
