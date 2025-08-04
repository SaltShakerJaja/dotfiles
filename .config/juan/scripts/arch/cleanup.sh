#!/bin/bash
clear
aur_helper="$(cat ~/.config/juan/settings/aur.sh)"
figlet -f smslant "Cleanup"
echo
$aur_helper -Scc
