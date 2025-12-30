
set :package_updates do
  sudo "DEBCONF_TERSE=yes DEBIAN_PRIORITY='critical' DEBIAN_FRONTEND=noninteractive apt-get --force-yes -qyu update"
  sudo "DEBCONF_TERSE=yes DEBIAN_PRIORITY='critical' DEBIAN_FRONTEND=noninteractive apt-get --force-yes -qyu upgrade"
end

set :unattended_upgrades do
  apt "unattended-upgrades"
  apt "wget"

  replace "/etc/apt/apt.conf.d/50unattended-upgrades", "//.*\"Ubuntu lucid-updates\";", "\"Ubuntu lucid-updates\";", :sudo => true
  replace "/etc/apt/apt.conf.d/50unattended-upgrades", "//Unattended-Upgrade::Mail \"root@localhost\";", "Unattended-Upgrade::Mail \"root@localhost\";", :sudo => true

  append "/etc/apt/apt.conf.d/50unattended-upgrades", "APT::Periodic::Update-Package-Lists \"1\";", :sudo => true
  append "/etc/apt/apt.conf.d/50unattended-upgrades", "APT::Periodic::Download-Upgradeable-Packages \"1\";", :sudo => true
  append "/etc/apt/apt.conf.d/50unattended-upgrades", "APT::Periodic::Unattended-Upgrade \"1\";", :sudo => true
end

set :bash_completion do  
  apt "bash-completion"
end

set :vim do
  apt "vim"
end

set :emacs do
  apt "emacs"
end

set :manpages do
  apt "man-db"
end

set :htop do
  apt "htop"
end

set :curl do
  apt "curl"
end

set :traceroute do
  apt "traceroute"
end

set :git do
  apt "git-core"
end

set :passwordless_sudo do
  append "/etc/sudoers", "#{user} ALL=NOPASSWD: ALL", :sudo => true
end

set :passwordless_commands do
  password_free_commands.each do |command|
    append "/etc/sudoers", "#{user} ALL=NOPASSWD: #{command}", :sudo => true
  end
end
