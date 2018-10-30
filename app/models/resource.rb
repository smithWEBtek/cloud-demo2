class Resource < ApplicationRecord

	def self.load
		Resource.all{|r|r.delete}
		response = Cloudinary::Api.resources(resource: 'image', format: 'pdf', max_results: 500)		
		response['resources'].each do |resource|
			Resource.create(
				public_id: resource["public_id"].gsub('.pdf', ''), 
				width: 	resource["width"],
				height: resource["height"],
				format: resource["format"],
				url: resource["url"],
				secure_url: resource["secure_url"])
		end
	response['resources'].count
	end
end
