class Resource < ApplicationRecord

	def self.load
		response = Cloudinary::Api.resources(resource: 'image', format: 'pdf', max_results: 500)
		response['resources'].each do |resource|

			if !Resource.find_by(public_id: resource["public_id"])
				Resource.create(
					public_id: resource["public_id"].gsub('.pdf', ''), 
					width: 	resource["width"],
					height: resource["height"],
					format: resource["format"],
					url: resource["url"],
					secure_url: resource["secure_url"])
			end
		end
	end	
end
