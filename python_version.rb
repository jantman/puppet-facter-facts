# Facter facts for python versions and paths
# https://github.com/jantman/puppet-facter-facts/blob/master/python_version.rb

Facter.add("python_default_version") do
  setcode do
    begin
      Facter::Util::Resolution.exec('python -c "import sys; print(\'.\'.join(map(str, sys.version_info[:3])));" 2>/dev/null')
    rescue
      false
    end
  end
end

Facter.add("python_default_bin") do
  setcode do
    begin
      /^(\/.+)$/.match(Facter::Util::Resolution.exec('which python 2>/dev/null'))[1]
    rescue
      false
    end
  end
end

Facter.add("python_usrbin_version") do
  setcode do
    begin
      Facter::Util::Resolution.exec('/usr/bin/python -c "import sys; print(\'.\'.join(map(str, sys.version_info[:3])));" 2>/dev/null')
    rescue
      false
    end
  end
end

def add_python_paths

  pythons = {
    'python24_path' => 'python2.4',
    'python26_path' => 'python2.6',
    'python27_path' => 'python2.7',
    'python31_path' => 'python3.1',
    'python32_path' => 'python3.2',
    'python33_path' => 'python3.3',
    'python34_path' => 'python3.4',
  }

  versions = Array.new
  python_latest_path = nil
  python_latest_ver = nil

  pythons.keys.sort.each do|factname|
    binname = pythons[factname]
    Facter.add(factname) do
      begin
        path = /^(\/.+)$/.match(Facter::Util::Resolution.exec("which #{binname} 2>/dev/null"))[1]
        ver = Facter::Util::Resolution.exec("#{path} -c \"import sys; print('.'.join(map(str, sys.version_info[:3])));\" 2>/dev/null")
        versions.push(ver)
        python_latest_path = path
        python_latest_ver = ver
        setcode do
          path
        end
      rescue
        nil
      end
    end
  end

  Facter.add("python_latest_path") do
    setcode do
      python_latest_path
    end
  end

  Facter.add("python_latest_version") do
    setcode do
      python_latest_ver
    end
  end

  Facter.add("python_versions") do
    setcode do
      versions
    end
  end

  Facter.add("python_versions_str") do
    setcode do
      versions.join(",")
    end
  end

end

add_python_paths()
