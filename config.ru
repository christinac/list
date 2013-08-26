Dir.chdir '/root/www/christinacacioppo.com/blog/current' 
$:.unshift Dir.pwd

require 'list.rb'
run CCForm.new