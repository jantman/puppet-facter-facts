# Facter facts for python virtualenv versions and paths
# https://github.com/jantman/puppet-facter-facts/blob/master/virtualenv_version.rb

Facter.add("virtualenv_default_version") do
  setcode do
    begin
      /^.*(\d+\.\d+\.\d+)$/.match(Facter::Util::Resolution.exec('virtualenv --version 2>&1'))[1]
    rescue
      false
    end
  end
end

Facter.add("virtualenv_default_bin") do
  setcode do
    begin
      /^(\/.+)$/.match(Facter::Util::Resolution.exec('which virtualenv 2>/dev/null'))[1]
    rescue
      false
    end
  end
end

Facter.add("virtualenv_usrbin_version") do
  setcode do
    begin
      /^.*(\d+\.\d+\.\d+)$/.match(Facter::Util::Resolution.exec('/usr/bin/virtualenv --version 2>&1'))[1]
    rescue
      false
    end
  end
end

def add_virtualenv_paths

  virtualenvs = {
    'virtualenv24_path' => 'virtualenv-2.4',
    'virtualenv26_path' => 'virtualenv-2.6',
    'virtualenv27_path' => 'virtualenv-2.7',
    'virtualenv31_path' => 'virtualenv-3.1',
    'virtualenv32_path' => 'virtualenv-3.2',
    'virtualenv33_path' => 'virtualenv-3.3',
    'virtualenv34_path' => 'virtualenv-3.4',
  }

  versions = Array.new
  virtualenv_latest_path = nil
  virtualenv_latest_ver = nil

  virtualenvs.each do|factname, binname|
    Facter.add(factname) do
      begin
        path = /^(\/.+)$/.match(Facter::Util::Resolution.exec("which #{binname} 2>/dev/null"))[1]
        ver = /^.*(\d+\.\d+\.\d+)$/.match(Facter::Util::Resolution.exec("#{path} --version 2>&1"))[1]
        versions.push(ver)
        virtualenv_latest_path = path
        virtualenv_latest_ver = ver
        setcode do
          path
        end
      rescue
        nil
      end
    end
  end

  versions = versions.uniq

  Facter.add("virtualenv_latest_path") do
    setcode do
      virtualenv_latest_path
    end
  end

  Facter.add("virtualenv_latest_version") do
    setcode do
      virtualenv_latest_ver
    end
  end

  Facter.add("virtualenv_versions") do
    setcode do
      versions
    end
  end

  Facter.add("virtualenv_versions_str") do
    setcode do
      versions.join(",")
    end
  end

end

add_virtualenv_paths()
