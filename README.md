# check_custom.sh

A small plugin to execute multiple plugin calls definend
in a local file. Essentially a simpler [check_multi](https://github.com/flackem/check_multi).

The path to a "config file" (really a list of commands to execute is hardcoded in the script ("/usr/lib/nagios/plugins/contrib/processes_to_check.txt" by default).

It could look like this:
```
/usr/lib/nagios/plugins/check_load -w 5,4,3 -c 8,7,6

/usr/lib/nagios/plugins/check_disk -w 5% -c 2%
```

The whole script is not very sophisticated, but might be quite helpful
if someone has the urgent need to define checks locally.
