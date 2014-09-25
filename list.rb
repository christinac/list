require 'rubygems'
require 'sinatra'
require 'lib/subscriber'

class CCForm < Sinatra::Base

	get '/updates' do 
		erb :list
	end

	post '/updates' do
		subscriber = Subscriber.new(params, request.ip)
		subscriber.email_me()
		subscriber.save('cc')
		erb :thanks
	end

	post '/updates/aces' do
		subscriber = Subscriber.new(params, request.ip)
		subscriber.email_me("[aces-post] subscription")
		subscriber.save("aces")
	end

	helpers do
	  def nest_template(path)
	  	path = File.expand_path(File.dirname(__FILE__)) + '/' + path
    	content = File.read(File.expand_path(path))
	    t = ERB.new(content)
	    t.result(binding)
	  end
	end
end