output = %x{sudo -V 2>&1}

if $?.exitstatus and output.match(/[Ss]udo[ \-][Vv]ersion ([\d\.]+)/)

  Facter.add("sudoversion") do
    setcode do
      $1
    end
  end
end
