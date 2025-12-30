
Gem::Specification.new do |s|
  s.name = %q{doo-extras}
  s.version = "0.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Mat Trudel"]
  s.date = %q{2011-04-11}
  s.description = %q{doo-extras provides a base set of recipes for doo for building out common daemons and configuration models on Ubuntu based servers}
  s.email = ["mat@geeky.net"]
  s.extra_rdoc_files = [
    "README.md"
  ]
  s.files = [
    "README.md",
    "lib/doo-extras.rb",
    "lib/doo-extras/ubuntu.rb",
    "lib/doo-extras/recipes/apache.rb",
    "lib/doo-extras/recipes/backupninja.rb",
    "lib/doo-extras/recipes/basic.rb",
    "lib/doo-extras/recipes/jetty.rb",
    "lib/doo-extras/recipes/memcached.rb",
    "lib/doo-extras/recipes/mongodb.rb",
    "lib/doo-extras/recipes/monit.rb",
    "lib/doo-extras/recipes/munin.rb",
    "lib/doo-extras/recipes/mysql.rb",
    "lib/doo-extras/recipes/nginx.rb",
    "lib/doo-extras/recipes/node.rb",
    "lib/doo-extras/recipes/ntp.rb",
    "lib/doo-extras/recipes/php.rb",
    "lib/doo-extras/recipes/python.rb",
    "lib/doo-extras/recipes/rails.rb",
    "lib/doo-extras/recipes/redis.rb",
    "lib/doo-extras/recipes/ruby.rb",
    "lib/doo-extras/recipes/smtp.rb",
    "lib/doo-extras/recipes/ssh.rb",
  ]
  s.homepage = %q{http://github.com/drylikov/doo-extras}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{A base set of recipes for building out common daemons using doo}

  s.add_dependency("doo")
end

