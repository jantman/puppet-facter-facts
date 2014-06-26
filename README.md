puppet-facter-facts
===================

a collection of facts for user with [Facter](https://github.com/puppetlabs/facter) and [Puppet](https://github.com/puppetlabs/puppet)

*   catalog_config_version.rb - fact for the version of the last applied
    catalog, taken from the "version" element (config_version) of the
    catalog. (This really is obsolete now that we have [config_version](http://docs.puppetlabs.com/references/latest/configuration.html#configversion).
*   has_netbackup.rb - simple test for whether or not (boolean)
    [Symantec Netbackup](http://www.symantec.com/netbackup) is installed,
    based on presence of /usr/openv/netbackup/bin directory. Can be used to
    automatically trigger generation of include/exclude files.
*   syslog_bin.rb - fact for the full path to the CURRENTLY RUNNING
    syslog daemon binary. Checks the ps output (using the ps fact) for
    the currently running syslog binary (assuming the name matches
    *sys\w*log*). If the process name is not an absolute path, reads
    /proc/PID/exe symlink for the absolute path. Note this is only for the
    currently running daemon; it will work on systems with more than one
    syslog installed but only one running, but might pose problems if you're
    trying to switch to a new syslog version.
*   syslog_type.rb - fact for the syslog daemon type. Requires the
    syslog_bin fact, and simply translates its name to a single string
    value. Currently, "rsyslog", "syslogd", or "unknown".
*   syslog_version.rb - fact for the string version of the syslog
    daemon. Requires the syslog_bin fact, and currently supports
    syslogd/sysklogd (/sbin/syslogd) and rsyslog (/sbin/rsyslogd).
*   puppet_classes_csv.rb - retrieves a list of the currently applied puppet
    classes from /var/lib/puppet/classes.txt, and returns them as a CSV
    list. This code is almost completely identical to Matthew Nicholson's at
    http://sjoeboo.github.com/blog/2012/07/31/updated-puppet-facts-for-puppet-classes/
    except it returns CSV instead of JSON.
*   python_version.rb - Facts for the paths and versions of installed Python interpreters,
    as well as a list of all available versions, and the best available versions. Sample
	output:
        python27_path => /usr/bin/python2.7
        python33_path => /usr/bin/python3.3
        python_default_bin => /usr/bin/python
        python_default_version => 3.3.5
        python_latest_path => /usr/bin/python3.3
        python_latest_version => 3.3.5
        python_usrbin_version => 3.3.5
        python_versions => ["2.7.6", "3.3.5"]
        python_versions_str => 2.7.6,3.3.5
*   virtualenv_version.rb - Facts for the paths and versions of installed virtualenv scripts,
    as well as a list of all available versions and the best available versions. Sample
	output:
        virtualenv27_path => /usr/bin/virtualenv-2.7
        virtualenv33_path => /usr/bin/virtualenv-3.3
        virtualenv_default_bin => /usr/bin/virtualenv
        virtualenv_default_version => 1.11.4
        virtualenv_latest_path => /usr/bin/virtualenv-3.3
        virtualenv_latest_version => 1.11.4
        virtualenv_usrbin_version => 1.11.4
        virtualenv_versions => ["1.11.4"]
        virtualenv_versions_str => 1.11.4
