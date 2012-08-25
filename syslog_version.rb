#
# facter fact for syslog daemon version
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

Facter.add("syslog_version") do
  confine :syslog_bin => "/sbin/syslogd"
  
  result = nil
  output = Facter::Util::Resolution.exec("#{syslog_bin} -v")
  if not output.nil?
    output.each_line do |ver|
      if ver =~ /^syslogd\s+([\d|\.]+)/
        result = $1
      end
    end
  end
  
  setcode { result }
end

Facter.add("syslog_version") do
  confine :syslog_bin => "/sbin/rsyslogd"
  
  result = nil
  output = Facter::Util::Resolution.exec("#{syslog_bin} -v")
  if not output.nil?
    output.each_line do |ver|
      if ver =~ /^rsyslogd\s+([\d|\.]+)/
        result = $1
      end
    end
  end
  
  setcode { result }
end

Facter.add("syslog_version") do
  confine :syslog_bin => "unknown"
  
  setcode { nil }
end
