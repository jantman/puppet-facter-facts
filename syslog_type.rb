#
# facter fact for syslog version
#
# Copyright 2012 Jason Antman <jason@jasonantman.com>.
# Available from: <https://github.com/jantman/puppet-facter-facts>
#
# Licensed under the Apache License, Version 2.0
# <http://www.apache.org/licenses/LICENSE-2.0>
# * use it anywhere you want, however you want, provided that this header is left intact,
#   and that if redistributed, credit is given to me
# * It is strongly requested, but not technically required, that any changes/improvements
#   be submitted back to me, either as a GitHub Pull Request, or a patch emailed to the above address.
#

require 'facter'
require 'pathname'
begin
        Facter.syslog_bin
rescue
        Facter.loadfacts()
end

# ps command for our architecture
syslog_bin = Facter.value('syslog_bin')

Facter.add("syslog_type") do
  confine :syslog_bin => "/sbin/syslogd"
  
  setcode { 'syslogd' }
end

Facter.add("syslog_type") do
  confine :syslog_bin => "/sbin/rsyslogd"
  
  setcode { 'rsyslog' }
end

Facter.add("syslog_type") do
  confine :syslog_bin => "unknown"
  
  setcode { 'unknown' }
end
