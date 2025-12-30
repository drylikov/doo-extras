
set :rails do
  run "[[ -s /usr/local/lib/rvm ]] && source /usr/local/lib/rvm && gem install --no-rdoc --no-ri unicorn rails bundler"
end
