#exec	startfluxbox

export LANG=en_US.UTF-8
export XMODIFIERS='@im=fcitx'
export GTK_IM_MODULE=xim
export QT_IM_MODULE=xim

fcitx -d
urxvtd -q -o -f

cairo-dock -c -f &
emerald --replace &
conky -d
exec pcmanfm --desktop -d --set-wallpaper=/home/hudong/.themes/Leopard/gtk-2.0/wallpaper.png --wallpaper-mode=center &
exec ck-launch-session compiz --replace ccp --indirect-rendering
