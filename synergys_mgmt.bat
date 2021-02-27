@echo off

:: Be sure to add `C:\Program Files\Synergy` (or equivalent) to system Path.

:: 1. Try hosting on JC-SB2 wired
synergys --no-restart --address 192.168.1.52 --name JC-SB2-wired --config synergy_office_sb2_right.conf

:: 2. Try hosting on JC-SB2 wireless
synergys --no-restart --address 192.168.1.51 --name JC-SB2-wireless --config synergy_office_sb2_right.conf

:: 3. Try hosting on VS-P52S wired
synergys --no-restart --address 192.168.1.54 --name VS-P52S-wired --config synergy_office_sb2_right.conf

:: 4. Try hosting on VS-P52S wireless
synergys --no-restart --address 192.168.1.53 --name VS-P52S-wireless --config synergy_office_sb2_right.conf
