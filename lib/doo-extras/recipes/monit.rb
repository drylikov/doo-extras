
set :monit do
  if defined? monitrc_file
    if_fails "[ -x /usr/sbin/monit ]" do
      apt 'monit'
      
      replace "/etc/default/monit", "^startup=0", "startup=1", :sudo => true
      
      put monitrc_file, "/etc/monit/monitrc", :sudo => true, :owner => "root", :group => "root"
    end
    
    sudo "service monit restart"

    if defined? monit_extras
      [monit_extras].flatten.each do |extra|
        put extra, "/etc/monit/conf.d/#{File.basename(extra)}", :sudo => true, :owner => "root", :group => "root"
      end
      
      sudo "service monit restart"
    end
  end
end
