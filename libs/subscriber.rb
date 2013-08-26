require 'time'

class Subscriber
	attr_reader :name, :email, :phone, :ipaddress, :date_added, :active

	def save(subscriber)
		# TODO: save this person somewhere!
	end

	def initialize(options)
		@name = options[:name]
		@email = options[:email]
		@phone = options[:phone]
		@updates = options[:frequency] == 'updates'
		@ipaddress = options[:ipaddress]
		@date_added = Time.now()
		@active = true
	end
end