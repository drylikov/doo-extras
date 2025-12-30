
set :apache do
  if_fails "[ -x /usr/sbin/httpd ]" do
    apt "apache2-mpm-prefork"
  end
  
  if defined? apache_config_files
    apache_config_files.each do |file|
      put file, "/etc/apache2/conf.d/#{File.basename file}", :sudo => true
    end
    sudo "service apache2 restart"
  end  
end
