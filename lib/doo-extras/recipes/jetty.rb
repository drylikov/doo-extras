
set :jetty do
  
  if_fails "[ -d /usr/share/jetty ]" do  
    apt 'solr-jetty'
    apt 'openjdk-6-jdk'
  end
  replace "/etc/dfault/jetty", "^NO_START=1", "NO_START=0", :sudo => true
  if defined? jetty_bind_address
    replace "/etc/dfault/jetty", "^JETTY_HOST=.*", "JETTY_HOST=#{jetty_bind_address}", :sudo => true
  end
  if defined? jetty_bind_port
    replace "/etc/dfault/jetty", "^JETTY_PORT=.*", "JETTY_PORT=#{jetty_bind_port}", :sudo => true
  end
  if defined? jetty_max_memory
    replace "/etc/dfault/jetty", "^JAVA_OPTIONS=.*", "JAVA_OPTIONS=\\\"-Xmx#{jetty_max_memory} -Djava.awt.headless=true\\\"", :sudo => true
  end

  sudo "service jetty --full-restart"
end
