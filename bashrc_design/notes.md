### Question
---
Is there any way that i can auto run a python script at boot and see its output on the terminal other than editing the .bashrc file ?

I tried using crontab job and putting myscript in /etc/init.d/ directory but these two methods require a log file to see the output and that's not what i want.

### Answer 1
---
You shouldn't put scripts into .bashrc or .profile. This files are executed when you login in console every time, not when system startup. It could hang your login session, and make raspberry pi unable to log in to. And of course can be executet multiple times, one for each console session.

To run script at startup, when the script is not intended to run all the time, I suggest to use corntab:

```bash
edit crontab config
$ crontab -e
```

```
# add line in crontab config file
@reboot /path/to/the/script arguments
# save
```

To run script that must start with startup and run all the time raspberry pi is running, you should create service. This way is much more complicated, but gives you control what and when is running, especially when you haven't direct access to raspberry pi.


### Answer 2
---
Actually, .bashrc won't work to start something on boot. You might try running stuff on /etc/rc.local, that will print output to what you see during boot time. But in order to work "right" your script has to either finish or it has to go into the background. If it hangs forever without letting execution continue, boot sequence won't finish.

Addendum: Real question was related to user login time, not boot time. The answer is to use ~/.profile.



### Upgrading from 3.2 bash to 5 bash on MacOS 

[https://itnext.io/upgrading-bash-on-macos-7138bd1066ba]
