require 'json'
require 'time'
require 'rest_client'

class Subscriber
	attr_reader :name, :email, :phone, :ipaddress, :date_added, :active

	BaseDir = '/data'

	def path_for_type(type)
		BaseDir + "/#{type}_#{@id}.json"
	end

	def self.all(type)
		Dir.glob(BaseDir + "/#{type}_*.json").map do |file|
			subscriber = JSON.load(File.read(file))
			id = File.basename(file, '.json')

			self.new({
				:id => id,
				:name => subscriber['name'],
				:email => subscriber['email'],
				:phone => subscriber['phone'],
				:updates => subscriber['updates'],
				:date_added => subscriber['date_added'],
				:active => subscriber['active']},
				subscriber['ipaddress']
			)
		end
	end

	def save(type)
		filename = path_for_type(type)
		File.open(filename, "w") do |f|
			hash = {}
			instance_variables.each {|var| hash[var.to_s.delete("@")] = instance_variable_get(var) }
			f.puts(hash.to_json)
		end
	end

	def email_me(subject = "Subscription")
		begin
			RestClient.post "https://api:key-95f637w6x7efgar8u30x8eh-ajvfrf45@api.mailgun.net/v2/christinacacioppo.mailgun.org/messages",
			:from => "CC.com <list-bot@christinacacioppo.com>",
			:to => "ccacioppo+subscriber@gmail.com",
			:subject => subject,
			:text => "%s (%s) subscribed! Does s/he want all the updates? %s" % [@name, @email, @updates]
		rescue => e
			puts e.response
		end
	end

	def initialize(options, ipaddress)
		@id = Time.now().strftime('%m%H%Y') + '-' + options[:email]
		@name = options[:name]
		@email = options[:email]
		@phone = options[:phone]
		@updates = options[:frequency] == 'updates'
		@ipaddress = ipaddress
		@date_added = Time.now()
		@active = true
	end
end
