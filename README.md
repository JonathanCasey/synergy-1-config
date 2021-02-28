# Synergy 1 config

Configuration files (server and client) for
[synergy 1 by symless](https://symless.com/synergy).


## Quick Usage
This is intended to run one of the following depending on which machine, where
those machines are either servers or clients:
```
# Run one of the following
synergyc_office-tvpc-ir_mgmt.bat
synergyc_office-tvpc-ol_mgmt.bat
synergys_p52s_mgmt.bat
synergys_sb2_mgmt.bat
```


## Permanent Usage
The real way to use this is as a service.  This is very dependent on the OS.

### Windows 10
The `Services` app and using an administrator command prompt to issue things
like `sc create synergy-server start= auto
binpath= "C:\path\to\synergy-1-config\synergys_sb2_mgmt.bat"
displayname= "Synergy Server"` and `sc delete synergy-server` using
[sc create](https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/sc-create)
and
[sc delete](https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/sc-delete)
sounds like a winning solution, right?

Turns out, Windows hates you and your stupid batch files.  This is not the way.

One way will be to use `Task Scheduler`, being sure to select hidden and
possibly [set to run as SYSTEM](https://stackoverflow.com/a/6568823), but that
should require more research to minimize escalation.

The way covered here requires installation of the
[Non-Sucking Service Manager (nssm)](https://nssm.cc/).


##### Installing and Starting
Ensure [`nssm`](https://nssm.cc/download) is downloaded and its directory has
been added to the path.

To install or edit a service with the GUI, use:
```
nssm install []<servicename>]
# Or to edit existing:
nssm edit <servicename>
```

To install and setup entirely via CLI (example shows server on SB2 machine, but
could be adapted to client and/or other machines as noted), open a command
prompt run as adminstrator:
```
# For client, replace "server" with "client" below
# Also replace *mgmt.bat as desired for server/client and which machine
nssm install synergy-server "C:\path\to\synergy-1-config\synergys_sb2_mgmt.bat"
nssm set synergy-server AppDirectory "C:\path\to\synergy-1-config"
nssm set synergy-server DisplayName "Synergy Server"
nssm set synergy-server Description "Wrapper for running Synergy Server on all relevant interfaces."
nssm set synergy-server Start SERVICE_AUTO_START
nssm set synergy-server AppThrottle 1500
nssm set synergy-server AppExit Default Restart
nssm set synergy-server AppRestartDelay 0

nssm set synergy-server Type SERVICE_INTERACTIVE_PROCESS



```







The relevant batch file can be installed as a service using the
[sc create](https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/sc-create)
command.

Run a command prompt as administrator:
```
# Example of installing server on SB2:
sc create synergy-server start= auto binpath= "C:\path\to\synergy-1-config\synergys_sb2_mgmt.bat" displayname= "Synergy Server"

# Or, example of installing client on OL:
sc create synergy-client start= auto binpath= "C:\path\to\synergy-1-config\synergyc_office-tvpc-ir_mgmt.bat" displayname= "Synergy Client"
```

Afterwards, open the `Services` app from Windows search and find the new synergy
service in the list.  Right-click and select `Properties`.  On the `Recovery`
tab, for each of the "failure" options, select "Restart the Service" from the
list.  The "Restart service after" should default to "1 minutes".  This can be
left as-is or possibly changed to 0 in order to restart immediately, but it may
be best to add some delay in the batch file in that case to avoid running too
much.

Finally, on the `General` tab, kick this off by clicking the `Start` button,
then `OK` below to apply all changes.


##### Stopping and Uninstalling
The service can be stopped anytime by opening the `Services` app from Windows
search and finding the synergy service in the list.  Right-click and select
`Stop` (or any other desired option).

To fully uninstall, the
[sc delete](https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/sc-delete)
is used.

Run a command prompt as administrator:
```
# Example of uninstalling server:
sc delete synergy-server

# Or, example of uninstalling client:
sc delete synergy-client
```

If a different service name was used, it can be found in the `Services` app,
finding the service, right-clicking and selecting `Properties`, and noting the
`Service name` at the top of the `General` tab.


##### Alternative restart mechanism
If a restart time of 30 seconds, for example, is desired; or if want to do the
restart looping in the batch file, it can be altered using something like the
following:
```
:Start
synergys <options>
:: All the other calls
TIMEOUT /T 30
GOTO:Start
```

This will give a 30 seconds at the end before starting the loop of all
server/client options in the batch file all over again.  This never ends, so the
batch file would need to be terminated with Ctrl-C if running manually or stop
the service if running as such.


### Linux (Ubuntu)
In addition to adapting the batch files to work as shell scripts, this will also
require using something like systemd.


### Mac OS X
Install Linux or buy a PC.  Just kidding...coming later, but probably never.
