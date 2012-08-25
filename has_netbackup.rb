#
# facter fact for whether or not /usr/openv/netbackup/bin, from Symantec NetBackup, exists
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

require 'puppet'
require 'facter'

if FileTest.directory?("/usr/openv/netbackup/bin")
    Facter.add("has_netbackup") do
        setcode { true }
    end
else
    Facter.add("has_netbackup") do
        setcode { false }
    end
end
