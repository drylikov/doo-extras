
set :mongo_server do
  source = "deb http://downloads.mongodb.org/distros/ubuntu 10.4 10gen"
  if_fails "grep '#{source}' /etc/apt/sources.list" do
    append "/etc/apt/sources.list", source, :sudo => true
    sudo "DEBCONF_TERSE='yes' DEBIAN_PRIORITY='critical' DEBIAN_FRONTEND=noninteractive apt-get --force-yes -qyu update"
  end 

  apt "mongodb-stable"

  if defined? mongo_bind_address
    append "/etc/mongodb.conf", "bind_ip = #{mongo_bind_address}", :sudo => true
    sudo "/etc/init.d/mongodb restart", :pty => false
  end
end
