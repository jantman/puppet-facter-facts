#
# facter fact for currently running syslog binary
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
        Facter.ps
rescue
        Facter.loadfacts()
end

# ps command for our architecture
ps_cmd = Facter.value('ps')

Facter.add("syslog_bin") do
  confine :kernel => %w{Linux FreeBSD OpenBSD SunOS HP-UX Darwin GNU/kFreeBSD}

  result = 'unknown'
  output = Facter::Util::Resolution.exec(ps_cmd) # run the ps command
  output.each_line do |s|
    if s =~ /^(\S+)\s+(\d+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S*sys\w*log[^\s]*).+$/ # match PS output - we need the PID and the command name
      # if we have a command name that's an abs path (^/), set and be done
      pidnum = $2
      psname = $8
      if pidnum == $$
        # skip it - this is the facter process itself, if called specifically for this fact
        next
      end
      if psname =~ /^\/.+/ 
        # our psname is an absolute path
        if FileTest.symlink?(psname)
          result = Pathname.new(psname).realpath.to_s
          break
        else
          result = psname
          break
        end
      else
        # else, we need to look at /proc/PID/exe and find the abs path
        if FileTest.symlink?("/proc/#{pidnum}/exe")
          result = Pathname.new("/proc/#{pidnum}/exe").realpath.to_s
          break
        end
      end
    end
  end
  setcode { result }
end
