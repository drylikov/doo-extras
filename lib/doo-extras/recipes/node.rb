
set :node do
  
  # Install node.js from source, since there aren't any debs for it yet
  %w( g++ curl libssl-dev apache2-utils ).each do |pkg|
    apt pkg
  end
  run 'mkdir -p src'
  run 'cd src; [ -d node ] || git clone git://github.com/joyent/node.git'
  run 'cd src/node && git pull && ./configure --prefix=/usr/local && make && sudo make install'
  
  # Install the node package manager
  run 'cd src; [ -d npm ] || git clone git://github.com/isaacs/npm.git'
  run 'cd src/npm && git checkout 0.3 && git pull && sudo make install'
end
