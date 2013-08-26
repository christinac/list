Dir.chdir '/root/www/christinacacioppo.com/list/current' 
$:.unshift Dir.pwd

require 'list.rb'
run CCForm.new