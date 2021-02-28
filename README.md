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


Option 2 is [Non-Sucking Service Manager (nssm)](https://nssm.cc/), but this has
its own challenges.  Windows seems to require this being run as the logged in
user -- running it in the background results in it being unable to get the
screen size/shape and consequently unable to leave the screen.  There are some
tricks to use, but since this also does not produce a tray icon even when done
as the logged in user with password saved, this is a no-go.


The way covered here will be to use `Task Scheduler`.  Still not ideal, but best
option right now.


##### Installing and Starting
Run `Task Scheduler` from Windows search.  On the right, click "Create Task...".
Note, to edit in the future, click "Task Scheduler Library" on the left and find
the task in the list.

The recommended settings to change:
1. On `General`, set `Name` to something like `Synergy Server`.
2. On `General`, set `Description` to something like "Wrapper for running
      Synergy Server on all relevant interfaces."
3. On `General`, leave `Run only when user is logged on` selected.
  1. You may be tempted to change this, but changing this with or without
        storing the password, or changing the user to anything including
        `SYSTEM` fails.  It will run and connect, but the screen will be wrong
        and no tray icon, so there's no actual operation on another screen.
4. On `General`, check `Run with highest privileges` to avoid having issues such
      as not being able to click on system apps on clients.
5. On `General`, check `Hidden`.  Not sure if it helps, but did it.
6. On `General`, select `Configure for:` to be `Windows 10` just in case.
7. On `Triggers`, select `New...`:
  1. Select `Begin the task:` to be `At startup`.
  2. Check `Repeat task every:`.
  3. After checking `Repeat task every:`, set the dropdown to `1 minute` (write
        in).
  4. Also set `for a duration of:` to `Indefinitely`.
  5. Make more triggers and repeat all steps for `Begin the task:` being
        `At log on`, `On workstation unlock`, and `At task
        creation/modification`.
8. On `Actions`, select `New...`:
  1. For the `Program/script`, enter `cmd.exe`.
  2. For the `Add arguments (optional):`, enter `/c ` followed by the
        appropriate full script path (e.g. full arg would be
       `/c "C:\path\to\synergy-1-config\synergys_sb2_mgmt.bat"`).
  3. For the `Start in (optional)`, enter the path to the repo root (e.g.
        `C:\path\to\synergy-1-config`).
9. On `Conditions`, uncheck `Start the task only if the computer is on AC power`
      if desired.
10. On `Conditions`, check `Start only if the following network connection is
      available` and select from the dropdown if desired.
11. On `Settings`, check `Run task as soon as possible after a scheduled start
      is missed`.
12. On `Settings`, uncheck `Stop the task if it runs longer than:`.

If the task is stopped and run manually, it does not seem to trigger the
auto-restart mechanism, so best way it to click properties and hit ok to hit the
"modify" trigger (even though nothing was changed).  In fact, it may be best to
disable the option to run manually by editing the task in Task Scheduler, going
to the `Settings` tab, and unchecking `Allow task to be run on demand`.

This can be repeated for the client, using the appropriate client management
script such as `C:\path\to\synergy-1-config\synergyc_office-tvpc-ir_mgmt.bat`,
an appropriate name like `Synergy Client`, and a better description like
"Wrapper for running Synergy Client to try all potential servers."

Note that this does open a command prompt and leave it open.  Not much can be
done with this at this time.  Best option may be to throw it on an empty desktop
when using multiple desktops.  Out of sight, out of mind, right?

The last trick is, to have this automatically run upon wake/boot, auto-sign in
for the user will be needed since these tasks only run when logged in.  This is
likely not an option everywhere for security reasons, but in case it is,
[this site](http://woshub.com/how-to-disable-password-login-in-windows-10/)
(who somehow has not figured out https in 2021 -_-) has good resources.  The
gpedit option to not require a password when a computer wakes in "Computer
Configuration -> Administrative Templates -> System -> Power Management -> Sleep
Settings" worked wonderfully.


##### Stopping and Uninstalling
This can be stopped to varying degrees.

The command prompt window can be closed to stop.  The task will likely reopen it
within a minute.

In Task Scheduler, right clicking the task and selecting `End` will also stop,
but again it is likely to be restarted within a minute.

In Task Scheduler, right clicking the task and selecting `Disable` will stop it
from restarting.  Note, to restart, will want to use the "modify" trick
mentioned above.

Finally, to fully uninstall, simply delete the task from Task Scheduler by
right clicking on the task and selecting `Delete`.


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



## Other Uses

### Bi-directional
There is nothing that stops a machine from being a server and a client at the
same time.

From limited experience, it seems this only partially works well.  Some
weirdness pops up when changing screens, things can jump around and be weird in
general.  This was not thoroughly tested, so it cannot be conclusively ruled
out, but neither is a simple/obvious solution readily available.
