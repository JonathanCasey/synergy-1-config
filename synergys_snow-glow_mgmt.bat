:: @echo off

:: Be sure to add `C:\Program Files\Synergy` (or equivalent) to system Path.

:Start

Rem s0. Try connecting to P52S/SB2 if it is already up
call synergyc_mgmt.bat SnowGlow

Rem s1. Try hosting on SnowGlow wired
synergys --no-restart --address 192.168.1.60 --name SnowGlow-wired --config synergy_office_snow-glow_right.conf

Rem Wait 30s before starting again
TIMEOUT /T 30
GOTO:Start
