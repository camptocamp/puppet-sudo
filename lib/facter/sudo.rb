output = %x{sudo -V 2>&1}

if $?.exitstatus and output.match(/Sudo version ([\d\.]+)/)

  Facter.add("sudoversion") do
    setcode do
      $1
    end
  end
end
