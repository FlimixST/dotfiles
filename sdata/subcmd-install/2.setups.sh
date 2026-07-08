# This script is meant to be sourced.
# It's not for directly running.

function setup_user_group(){
  if [[ -z $(getent group i2c) ]]; then
    x sudo groupadd i2c
  fi
  x sudo usermod -aG video,i2c,input "$(whoami)"
}
#####################################################################################
# These python packages are installed using uv into the venv (virtual environment). Once the folder of the venv gets deleted, they are all gone cleanly. So it's considered as setups, not dependencies.
showfun install-python-packages
v install-python-packages

showfun setup_user_group
v setup_user_group

v bash -c "echo i2c-dev | sudo tee /etc/modules-load.d/i2c-dev.conf"

if [[ ! -z "${DBUS_SESSION_BUS_ADDRESS}" ]]; then
  v systemctl --user enable ydotool --now
else
  v sudo systemctl --machine=$(whoami)@.host --user enable ydotool --now
fi

v gsettings set org.gnome.desktop.interface font-name 'Google Sans Flex Medium 11 @opsz=11,wght=500'
v gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

function setup_polkit_nopasswd() {
    local rules_file="sdata/subcmd-install/polkit-nopasswd.rules"
    if [ -f /etc/polkit-1/rules.d/10-nopasswd.rules ]; then
        echo "NOPASSWD polkit rule already present, skipping."
        return
    fi
    echo ""
    echo "Polkit NOPASSWD: Do you want to skip authentication dialogs for sudo operations?"
    echo "This copies a polkit rule so admin actions won't prompt for password."
    echo -n "Install? [y/N]: "
    read -r answer
    case "$answer" in
        y|Y)
            sudo cp "$rules_file" /etc/polkit-1/rules.d/10-nopasswd.rules
            echo "Polkit NOPASSWD rule installed."
            ;;
        *)
            echo "Skipping polkit NOPASSWD setup."
            ;;
    esac
}
showfun setup_polkit_nopasswd
v setup_polkit_nopasswd
