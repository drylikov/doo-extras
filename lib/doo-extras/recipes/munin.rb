
set :munin_server do
  apt "munin"
  
  if defined? munin_nginx_config
    apt "nginx"
    sudo "rm -f /etc/nginx/sites-enabled/default"
    put munin_nginx_config, "/etc/nginx/sites-available/#{File.basename(munin_nginx_config)}", :sudo => true
    sudo "ln -sf /etc/nginx/sites-available/#{File.basename(munin_nginx_config)} /etc/nginx/sites-enabled/"
    sudo "service nginx restart"
  end
end

set :munin_node do
  if defined? munin_extra_libs
    apt munin_extra_libs.join(" ")
  end

  apt "munin-node"

  append "/etc/munin/munin-node.conf", "allow #{munin_master}", :sudo => true

  if defined? munin_bind_address
    replace "/etc/munin/munin-node.conf", "^host \\*$", "host #{munin_bind_address}", :sudo => true
  end
  
  sudo "service munin-node restart"

  message <<-EOF
  You'll want to add a stanza like the following on your munin-master server:
  #{"*" * 78}
  [#{host}]
    address [The IP of the host in question]
    use_node_name yes
  #{"*" * 78}
  EOF
end

