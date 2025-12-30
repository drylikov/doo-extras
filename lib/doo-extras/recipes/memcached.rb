
set :memcached_munin do
  sudo "wget -O /usr/share/munin/plugins/memcached_multi http://exchange.munin-monitoring.org/plugins/memcached-multigraph/version/2/download"
  sudo "chmod +x /usr/share/munin/plugins/memcached_multi"   

  sudo "ln -sf /usr/share/munin/plugins/memcached_multi /etc/munin/plugins/memcached_multi_bytes"
  sudo "ln -sf /usr/share/munin/plugins/memcached_multi /etc/munin/plugins/memcached_multi_commands"
  sudo "ln -sf /usr/share/munin/plugins/memcached_multi /etc/munin/plugins/memcached_multi_conns"
  sudo "ln -sf /usr/share/munin/plugins/memcached_multi /etc/munin/plugins/memcached_multi_evictions"
  sudo "ln -sf /usr/share/munin/plugins/memcached_multi /etc/munin/plugins/memcached_multi_items"
  sudo "ln -sf /usr/share/munin/plugins/memcached_multi /etc/munin/plugins/memcached_multi_memory"

  sudo "service munin-node restart"
end

set :memcached do
  if_fails "[ -x /usr/bin/memcached ]" do
    apt "memcached"

    if defined? memcached_memory
      replace "/etc/memcached.conf", "^-m.*", "-m #{memcached_memory}", :sudo => true
      sudo "service memcached restart"
    end
  end

  memcached_munin
end
