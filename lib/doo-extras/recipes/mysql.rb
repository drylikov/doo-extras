
set :db do
  if_fails "grep 'deb http://repo.percona.com/apt lucid main' /etc/apt/sources.list" do
    append "/etc/apt/sources.list", "deb http://repo.percona.com/apt lucid main", :sudo => true
    sudo "DEBCONF_TERSE='yes' DEBIAN_PRIORITY='critical' DEBIAN_FRONTEND=noninteractive apt-get --force-yes -qyu update"
  end
  
  if_fails "[ -x /usr/sbin/mysqld ]" do
    apt 'percona-server-server maatkit'
  end  

  if defined? mysql_config_file
    put mysql_config_file, "/etc/mysql/conf.d/wellca.cnf", :sudo => true
    sudo "service mysql restart"
  end
end

set :db_lockdown do
  if_fails "[ -e .mysql_locked_down ]" do
    message <<-EOF
      #{"*" * 78}
      In the following interactive session, select the following options. 
      Note that all selections listed below are the default options presented 
      by mysql_secure_installation. Note that the initial root password is empty.
       - DO change the root password to a well defined secret
       - DO remove anonymous user
       - DO disallow remote root access
       - DO remove test database
       - DO reload privilege tables
      #{"*" * 78}    
    EOF
    sudo 'mysql_secure_installation'
    run "touch .mysql_locked_down"
  end
end
