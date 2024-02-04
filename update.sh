rm -rf /home/tbu/.config/gtk-3.0/settings.ini
rm -rf /home/tbu/.config/gtk-4.0/settings.ini
rm -rf /home/tbu/.gtkrc-2.0
rm -rf /home/tbu/.icons/default/index.theme
rm -rf /home/tbu/.config/Kvantum/kvantum.kvconfig
nix flake update
nixos-rebuild switch --flake .
