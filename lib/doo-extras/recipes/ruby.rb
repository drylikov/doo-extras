
set :ruby do
  %w(build-essential bison openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev).each do |pkg|
    apt pkg
  end

  run "sudo bash < <(curl -L http://bit.ly/rvm-install-system-wide)"

  append "/etc/profile.d/rvm.sh", "[[ -s \"/usr/local/lib/rvm\" ]] && source \"/usr/local/lib/rvm\"", :sudo => true
  sudo "chmod +x /etc/profile.d/rvm.sh"
  sudo "rvm install 1.9.2"
  sudo "rvm --default use 1.9.2"
  sudo "adduser #{user} rvm"
end

