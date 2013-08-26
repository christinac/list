God.watch do |w|
  w.name = "list"
  w.start = "shotgun /root/www/christinacacioppo.com/list/current/config.ru --port=6001"
  w.keepalive(:memory_max => 150.megabytes,
              :cpu_max => 50.percent)
end