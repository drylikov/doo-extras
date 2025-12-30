
set :nginx_munin do
  sudo "wget -O /usr/share/munin/plugins/nginx_request http://exchange.munin-monitoring.org/plugins/nginx_request/version/2/download"
  sudo "wget -O /usr/share/munin/plugins/nginx_status http://exchange.munin-monitoring.org/plugins/nginx_status/version/3/download"
  sudo "wget -O /usr/share/munin/plugins/nginx_memory http://exchange.munin-monitoring.org/plugins/nginx_memory/version/1/download" 

  sudo "chmod +x /usr/share/munin/plugins/nginx_request"
  sudo "chmod +x /usr/share/munin/plugins/nginx_status"
  sudo "chmod +x /usr/share/munin/plugins/nginx_memory"   

  sudo "ln -sf /usr/share/munin/plugins/nginx_request /etc/munin/plugins/nginx_request"
  sudo "ln -sf /usr/share/munin/plugins/nginx_status /etc/munin/plugins/nginx_status"
  sudo "ln -sf /usr/share/munin/plugins/nginx_memory /etc/munin/plugins/nginx_memory"

  append "/etc/munin/plugin-conf.d/nginx", "[nginx*]
  env.url http://localhost/nginx_status", :sudo => true
end

set :nginx do
  if_fails "[ -f /usr/sbin/nginx ]" do
    apt 'nginx'
  end

  if defined? nginx_config_files
    nginx_config_files.each do |file|
      put file, "/etc/nginx/conf.d/#{File.basename file}", :sudo => true
    end
    sudo "service nginx restart"
  end

  append "/etc/nginx/nginx.conf", "worker_rlimit_nofile 30000;", :sudo => true
  append "/etc/sysctl.conf", "fs.file-max = 70000", :sudo => true
  append "/etc/security/limits.conf", "www-data       soft    nofile   10000 ", :sudo => true
  append "/etc/security/limits.conf", "www-data       hard    nofile   30000 ", :sudo => true
  sudo "sysctl -p"
  sudo "service nginx restart"


  nginx_munin
end
