@echo off

:: Be sure to add `C:\Program Files\Synergy` (or equivalent) to system Path.

:Start

:: 0. Try connecting to SB2 if it is already up
call synergyc_mgmt.bat VS-P52S

:: 1. Try hosting on VS-P52S wired
synergys --no-restart --address 192.168.1.54 --name VS-P52S-wired --config synergy_office_p52s_right.conf

:: 2. Try hosting on VS-P52S wireless
synergys --no-restart --address 192.168.1.53 --name VS-P52S-wireless --config synergy_office_p52s_right.conf

:: Wait 30s before starting again
TIMEOUT /T 30
GOTO:Start
