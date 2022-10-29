:: @echo off

:: Be sure to add `C:\Program Files\Synergy` (or equivalent) to system Path.

Rem c1. Try connecting to SnowGlow wired
synergyc --no-restart --name %1 192.168.1.60

Rem c2. Try connecting to JC-SB2 wired
synergyc --no-restart --name %1 192.168.1.52

Rem c3. Try connecting to JC-SB2 wireless
synergyc --no-restart --name %1 192.168.1.51

Rem c4. Try connecting to VS-P52S wired
synergyc --no-restart --name %1 192.168.1.54

Rem c5. Try connecting to VS-P52S wireless
synergyc --no-restart --name %1 192.168.1.53
