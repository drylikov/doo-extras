
set :backupninja do
  if_fails "[ -x /usr/sbin/backupninja ]" do
    apt 'backupninja'
    apt 'duplicity'
    
    sudo "mkdir -p /root/.ssh"
    sudo "chmod 700 /root/.ssh"
    sudo "test -f /root/.ssh/id_rsa || sudo ssh-keygen -f /root/.ssh/id_rsa -P ''"
    message <<-EOF
      #{"*" * 78}
    
      The following is a public key that needs to be manually appended to the chosen account
      on the chosen backup server for this machine:
      
    EOF
    
    sudo "cat /root/.ssh/id_rsa.pub"
    
    message <<-EOF
    
      Please ensure that this key is installed, or backups won't work.
    
      You'll also have to run the first backup manually, in order to authorize 
      your backup host's key. Do this by running
    
      sudo backupninja -n
    
      #{"*" * 78}
    EOF
    
    replace "/etc/backupninja.conf", "reportsuccess = yes", "reportsuccess = no", :sudo => true
    replace "/etc/backupninja.conf", "when = everyday at 01:00", "when = #{backup_time}", :sudo => true
    
    run "mkdir -p /tmp/backup.d"
    put "#{backup_files_directory}/*", "/etc/backup.d/", :sudo => true, :owner => "root", :group => "root", :mode => "u+Xrw,go-rwx"
  end
end
