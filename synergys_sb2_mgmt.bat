:: @echo off

:: Be sure to add `C:\Program Files\Synergy` (or equivalent) to system Path.

:Start

Rem s0. Try connecting to P52S/SnowGlow if it is already up
call synergyc_mgmt.bat JC-SB2

Rem s1. Try hosting on JC-SB2 wired
synergys --no-restart --address 192.168.1.52 --name JC-SB2-wired --config synergy_office_sb2_right.conf

Rem s2. Try hosting on JC-SB2 wireless
synergys --no-restart --address 192.168.1.51 --name JC-SB2-wireless --config synergy_office_sb2_right.conf

Rem Wait 30s before starting again
TIMEOUT /T 30
GOTO:Start
