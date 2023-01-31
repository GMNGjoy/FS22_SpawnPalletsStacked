@ECHO OFF
tar.exe -a -c -f FS22_MineshaftBoost.zip --exclude="*.zip" --exclude="*.md" --exclude=".*" --exclude="_*" *
copy FS22_MineshaftBoost.zip ..\..\testing\ModsOfMods\.