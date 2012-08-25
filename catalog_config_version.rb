#
# facter fact for last applied config version, pulled from /var/lib/puppet/client_yaml/catalog/fqdn.yaml
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
require 'yaml'
require 'facter'

localconfig = ARGV[0] || "#{Puppet[:clientyamldir]}/catalog/#{ Facter.fqdn }.yaml"

unless File.exist?(localconfig)
  puts("Can't find #{ Facter.fqdn }.yaml")
  exit 1
end

lc = File.read(localconfig)

begin
  pup = Marshal.load(lc)
rescue TypeError
  pup = YAML.load(lc)
rescue Exception => e
  raise
end

if pup.class == Puppet::Resource::Catalog
        Facter.add("catalog_config_version") do
                setcode do
                        pup.version
                end
        end
else
        Facter.add("catalog_config_version") do
                setcode do
                        "unknown"
                end
        end
end
