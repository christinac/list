require 'rubygems'
require 'sinatra'
require 'lib/subscriber'

class CCForm < Sinatra::Base

	get '/list' do 
		erb :list
	end

	post '/list' do
		# TODO: find (and pass?) IP address
		subscriber = Subscriber.new(params)
		# TODO: email myself when someone subscribes?
	end