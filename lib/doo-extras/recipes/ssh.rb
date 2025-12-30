
set :ssh do
  if_fails "[ -x /usr/sbin/sshd ]" do
    apt "openssh-server"
  end
  if defined? ssh_bind_address
    replace "/etc/ssh/sshd_config", "#ListenAddress 0.0.0.0", "ListenAddress #{ssh_bind_address}\\nListenAddress 127.0.0.1", :sudo => true
    sudo "service ssh restart"
  end    

  if_fails "[ -e .ssh/authorized_keys ]" do
    run "mkdir -m 700 -p .ssh"
    put authorized_keys, ".ssh/authorized_keys", :mode => 600
  end
end

set :ssh_lockdown do
  replace "/etc/ssh/sshd_config", ".*PasswordAuthentication yes", "PasswordAuthentication no", :sudo => true
  replace "/etc/ssh/sshd_config", ".*PermitRootLogin yes", "PermitRootLogin no", :sudo => true
  append "/etc/ssh/sshd_config", "PermitTunnel yes", :sudo => true
  sudo "service ssh restart"
end
  
