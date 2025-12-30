
set :redis_munin do
  sudo "wget -O /usr/share/munin/plugins/redis http://exchange.munin-monitoring.org/plugins/redis/version/3/download"
  sudo "chmod +x /usr/share/munin/plugins/redis"   

  sudo "ln -sf /usr/share/munin/plugins/redis /etc/munin/plugins/redis_connected_clients"
  sudo "ln -sf /usr/share/munin/plugins/redis /etc/munin/plugins/redis_per_sec"
  sudo "ln -sf /usr/share/munin/plugins/redis /etc/munin/plugins/redis_used_memory"

  sudo "service munin-node restart"
end

set :redis do
  ["deb http://archive.ubuntu.com/ubuntu maverick main restricted universe",
  "deb http://archive.ubuntu.com/ubuntu maverick-updates main restricted universe",
  "deb http://archive.ubuntu.com/ubuntu maverick-security main restricted universe"].each do |source|
    if_fails "grep '#{source}' /etc/apt/sources.list" do
      append "/etc/apt/sources.list", source, :sudo => true
      sudo "DEBCONF_TERSE='yes' DEBIAN_PRIORITY='critical' DEBIAN_FRONTEND=noninteractive apt-get --force-yes -qyu update"
    end
  end

  append "/etc/apt/apt.conf.d/99lucidpin", "APT::Default-Release \"lucid\";", :sudo => true

  if_fails "[ -x /usr/bin/redis-server ]" do  
    apt "redis-server/maverick"
    if defined? redis_bind_address
      replace "/etc/redis/redis.conf", "^bind 127.0.0.1", "bind #{redis_bind_address}", :sudo => true
      sudo "/etc/init.d/redis-server restart", :pty => false
    end
  end

  redis_munin
end
