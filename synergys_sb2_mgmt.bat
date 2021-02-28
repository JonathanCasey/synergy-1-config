@echo off

:: Be sure to add `C:\Program Files\Synergy` (or equivalent) to system Path.

:: 0. Try connecting to P52S if it is already up
synergyc_mgmt.bat JC_SB2

:: 1. Try hosting on JC-SB2 wired
synergys --no-restart --address 192.168.1.52 --name JC_SB2_wired --config synergy_office_sb2_right.conf

:: 2. Try hosting on JC-SB2 wireless
synergys --no-restart --address 192.168.1.51 --name JC_SB2_wireless --config synergy_office_sb2_right.conf
