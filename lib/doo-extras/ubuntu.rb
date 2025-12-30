
require 'doo'

# Define the apt method as it exists on Ubuntu
def apt(package, opts = {})
  if opts[:interactive]
    sudo "DEBIAN_PRIORITY=critical apt-get install #{package}"
  else
    sudo "DEBCONF_TERSE=yes DEBIAN_PRIORITY=critical DEBIAN_FRONTEND=noninteractive apt-get --force-yes -qyu install #{package}"
  end
end

# Now load all of our recipes in
Dir[File.join(File.dirname(__FILE__), 'recipes', '*.rb')].each { |file| load file }
