:: @echo off

:: Be sure to add `C:\Program Files\Synergy` (or equivalent) to system Path.

:Start

Rem s0. Try connecting to SB2/SnowGlow if it is already up
call synergyc_mgmt.bat VS-P52S

Rem s1. Try hosting on VS-P52S wired
synergys --no-restart --address 192.168.1.54 --name VS-P52S-wired --config synergy_office_p52s_right.conf

Rem s2. Try hosting on VS-P52S wireless
synergys --no-restart --address 192.168.1.53 --name VS-P52S-wireless --config synergy_office_p52s_right.conf

Rem Wait 30s before starting again
TIMEOUT /T 30
GOTO:Start
