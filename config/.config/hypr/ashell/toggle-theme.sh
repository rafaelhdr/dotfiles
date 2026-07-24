#!/bin/bash
current=$(gsettings get org.gnome.desktop.interface color-scheme)

case "$1" in
    status)
        [[ "$current" == "'prefer-dark'" ]]
        ;;
    *)
        if [[ "$current" == "'prefer-dark'" ]]; then
            gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
            gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita'
        else
            gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
            gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
        fi
        ;;
esac
