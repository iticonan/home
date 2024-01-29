#!/bin/sh
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
  
  if [ -f $sysresources ]; then
      xrdb -merge $sysresources
  fi
  
  if [ -f $sysmodmap ]; then
      xmodmap $sysmodmap
  fi
  
  if [ -f "$userresources" ]; then
      xrdb -merge "$userresources"
  fi
  
  if [ -f "$usermodmap" ]; then
      xmodmap "$usermodmap"
  fi
  
  # start some nice programs
  
  if [ -d /etc/X11/xinit/xinitrc.d ] ; then
   for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do 
    [ -x "$f" ] && . "$f"
   done
   unset f
  fi

/lib/gsd-xsettings &
xinput disable 11
setxkbmap -rules evdev -model evdev -layout us -variant altgr-intl -option caps:escape
dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY
gsettings set org.gnome.desktop.interface color-scheme prefer-dark
xbindkeys
exec i3
