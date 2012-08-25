puppet-facter-facts
===================

a collection of facts for user with [Facter](https://github.com/puppetlabs/facter) and [Puppet](https://github.com/puppetlabs/puppet)

*   syslog_bin.rb - fact for the full path to the CURRENTLY RUNNING
    syslog daemon binary. Checks the ps output (using the ps fact) for
    the currently running syslog binary (assuming the name matches
    *sys\w*log*). If the process name is not an absolute path, reads
    /proc/PID/exe symlink for the absolute path. Note this is only for the
    currently running daemon; it will work on systems with more than one
    syslog installed but only one running, but might pose problems if you're
    trying to switch to a new syslog version.
*   syslog_version.rb - fact for the string version of the syslog
    daemon. Requires the syslog_bin fact, and currently supports
    syslogd/sysklogd (/sbin/syslogd) and rsyslog (/sbin/rsyslogd).
*   syslog_type.rb - fact for the syslog daemon type. Requires the
    syslog_bin fact, and simply translates its name to a single string
    value. Currently, "rsyslog", "syslogd", or "unknown".
*   puppet_classes_csv.rb - retrieves a list of the currently applied puppet
    classes from /var/lib/puppet/classes.txt, and returns them as a CSV
    list. This code is almost completely identical to Matthew Nicholson's at
    http://sjoeboo.github.com/blog/2012/07/31/updated-puppet-facts-for-puppet-classes/
    except it returns CSV instead of JSON.
*   has_netbackup.rb - simple test for whether or not (boolean)
    [Symantec Netbackup](http://www.symantec.com/netbackup) is installed,
    based on presence of /usr/openv/netbackup/bin directory. Can be used to
    automatically trigger generation of include/exclude files.
*   catalog_config_version.rb - fact for the version of the last applied
    catalog, taken from the "version" element (config_version) of the
    catalog. 

