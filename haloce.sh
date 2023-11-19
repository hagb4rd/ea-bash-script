#!/bin/sh
gamedir="/home/e/.wine/drive_c/Program Files/Microsoft Games/Halo Custom Edition"
cd "$gamedir"
#for i in "" 2 4 6 7; do wine msiexec /z msxml"$i"; done
for i in "" 2 6 7; do wine msiexec /z msxml"$i"; done
cd "$gamedir"
wine haloce_1.10_cracked.exe & wine AutoHotkey.exe taxi.ahk
#wine AutoHotkey.exe taxi.ahk
#wine haloce_1.10_cracked.exe
