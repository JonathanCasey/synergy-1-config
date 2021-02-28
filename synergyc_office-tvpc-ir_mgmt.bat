:: @echo off

:Start

call synergyc_mgmt.bat Office-TVPC-IR

Rem Wait 30s before starting again
TIMEOUT /T 30
GOTO:Start
