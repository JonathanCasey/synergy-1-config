@echo off

:: Be sure to add `C:\Program Files\Synergy` (or equivalent) to system Path.

:: 0. Try connecting to SB2 if it is already up
synergyc_mgmt.bat VS_P52S

:: 1. Try hosting on VS-P52S wired
synergys --no-restart --address 192.168.1.54 --name VS_P52S_wired --config synergy_office_p52s_right.conf

:: 2. Try hosting on VS-P52S wireless
synergys --no-restart --address 192.168.1.53 --name VS_P52S_wireless --config synergy_office_p52s_right.conf
