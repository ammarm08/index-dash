class Index < ActiveRecord::Base

	# Using the Figaro gem to handle environment variables
	BASE_URI = ENV["base_uri"]
	AUTH_KEY = ENV["auth_key"]

	# this parses my GET request so I know which indices I'm looking for
	def self.get_data
		response = get_request
		body = parse_request(response)
		message_hash = body["message"]
	end

	# this populates my empty indices hash with the name and id of each index.
	# I will use this method in my Index controller to show names of all indices
	def self.populate
		raw_data = get_data

		indices = {}
		raw_data.each do |item|
			name = item["name"]
			indices[name] = {:socialrank_id => item["id"]}
		end
		indices
	end

	# Grabs specifically all 30day engagement data for all brands in index
	def self.get_engagement(socialrank_id)
		response = post_request(socialrank_id)
		body = parse_request(response)
		message_hash = body["message"]

		engagement = {}
		message_hash.keys.each do |brand|
			engagement[brand] = {:total => self.sum_total(message_hash[brand]), :fromFollowers => self.sum_from_followers(message_hash[brand])}
		end
		engagement.sort_by{|brand, stats| stats[:total]}.reverse
	end

	# Grabs engagement data from each previous 30 days
	def self.daily_engagement(socialrank_id, brand_id)
		response = post_request(socialrank_id)
		body = parse_request(response)
		brand_hash = body["message"][brand_id]

		engagement = {}
		brand_hash.keys.each do |date|
			engagement[date] = {:total => brand_hash[date]["total_engagement"] , :fromFollowers => brand_hash[date]["followers_engagement"]}
		end
		engagement.sort_by{|date, stats| date}
	end

	private

	def self.get_request
		uri = BASE_URI + "/indices"
		header = {"x-sr-code" => AUTH_KEY}

		request = Typhoeus.get(uri, :headers => header)
	end

	def self.post_request(socialrank_id)
		uri = BASE_URI + "/export_index_data"
		header = {"x-sr-code" => AUTH_KEY, "Content-Type" => "application/json"}

		request = Typhoeus::Request.new(uri, :method => :post, :headers => header, :body => JSON.dump({ "index_id": socialrank_id }))
		request.run
	end

	def self.parse_request(response)
		response_body = JSON.parse(response.response_body)
	end

	def self.sum_total(input)
		total = 0
		input.keys.each do |date|
			total += input[date]["total_engagement"]
		end

		total
	end

	def self.sum_from_followers(input)
		total = 0
		input.keys.each do |date|
			total += input[date]["followers_engagement"]
		end

		total
	end

end
