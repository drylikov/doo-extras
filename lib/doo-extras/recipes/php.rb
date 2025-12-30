
set :php_config do
  if defined? php_config_files
    php_config_files.each do |file|
      put file, "/etc/php5/conf.d/#{File.basename file}", :sudo => true
    end
  end
end

set :php do
  %w( php5 php5-cli php5-mysql php5-memcache php5-curl php-pear php5-gd php-apc php5-geoip php5-sqlite php5-dev ).each do |pkg|
    apt pkg
  end  
  php_config
end

set :php_zmq do
  run 'cd src; [ -d php-zmq ] || git clone git://github.com/mkoppanen/php-zmq.git'
  run 'cd src/php-zmq; git pull && phpize && ./configure && make && sudo make install'
  append "/etc/php5/conf.d/zmq.ini", "extension=zmq.so", :sudo => true
end

set :php_mongo do
  sudo 'pecl install mongo'
  append "/etc/php5/conf.d/mongo.ini", "extension=mongo.so", :sudo => true
end

set :php_cli do
  %w( php5-cli php5-mysql php5-curl ).each do |pkg|
    apt pkg
  end  
  php_config
end
