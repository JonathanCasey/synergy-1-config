@echo off

:: Be sure to add `C:\Program Files\Synergy` (or equivalent) to system Path.

:: 1. Try connecting to JC-SB2 wired
synergyc --no-restart --name %1 192.168.1.52

:: 2. Try connecting to JC-SB2 wireless
synergyc --no-restart --name %1 192.168.1.52

:: 3. Try connecting to VS-P52S wired
synergyc --no-restart --name %1 192.168.1.52

:: 4. Try connecting to VS-P52S wireless
synergyc --no-restart --name %1 192.168.1.52
