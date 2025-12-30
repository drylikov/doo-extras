
set :smtp_base do
  if_fails "[ -x /usr/sbin/postfix ]" do  
    apt "postfix"
  end
  
  if_fails "[ -x /usr/bin/bsd-mailx ]" do
    apt "bsd-mailx"
  end

  append "/etc/aliases", "root: #{admin_email}", :sudo => true
  sudo "newaliases"
end

set :smtp_local do
  smtp_base  
  replace "/etc/postfix/main.cf", "inet_interfaces =.*", "inet_interfaces = loopback-only", :sudo => true
  replace "/etc/postfix/main.cf", "relayhost =.*", "relayhost = #{smtp_relay_host}", :sudo => true
  sudo "service postfix restart"
end

set :smtp_relay do
  smtp_base
  
  if_fails "[ -x /usr/sbin/opendkim ]" do  
    apt "opendkim"
    opendkim_conf_files.each do |file|
      put file, "/etc/#{File.basename(file)}", :sudo => true, :owner => "root", :group => "opendkim"
    end
    sudo "service opendkim restart"
  end
  
  ["smtpd_authorized_verp_clients = $mynetworks",
  "milter_default_action = accept",
  "milter_protocol = 2",
  "smtpd_milters = inet:localhost:8891",
  "non_smtpd_milters = inet:localhost:8891"].each do |line|
    append "/etc/postfix/main.cf", line, :sudo => true
  end
  
  replace "/etc/postfix/main.cf", "myhostname =.*", "myhostname = #{smtp_external_hostname}", :sudo => true
  replace "/etc/postfix/main.cf", "mydestination =.*", "mydestination = #{smtp_destination}", :sudo => true
  replace "/etc/postfix/main.cf", "mynetworks =.*", "mynetworks = 127.0.0.0/8 [::ffff:127.0.0.0]/104 [::1]/128 #{relay_network}", :sudo => true
  sudo "service postfix restart"
end
