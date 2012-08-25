#
# facter fact for puppet classes on node, pulled from /var/lib/puppet/classes.txt, as a CSV list
# this code is almost identical to Matthew Nicholson's fact from:
# <http://sjoeboo.github.com/blog/2012/07/31/updated-puppet-facts-for-puppet-classes/>
# except that I return CSV instead of JSON. Credit goes to him for the work.
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
begin
        Facter.hostname
        Facter.fqdn
rescue
        Facter.loadfacts()
end
hostname = Facter.value('hostname')
fqdn = Facter.value('fqdn')

classes_txt = "/var/lib/puppet/classes.txt"

if File.exists?(classes_txt) then
        f = File.new(classes_txt)
        classes = Array.new()
        f.readlines.each do |line|
                line = line.chomp.to_s
                line = line.sub(" ","_")
                classes.push(line)
        end
        classes.delete("settings")
        classes.delete("#{hostname}")
        classes.delete("#{fqdn}")
        Facter.add("puppet_classes_csv") do
                setcode do
                        classes.join(",")
                end
        end
end

