class ResourcesController < ApplicationController
	class DemoController < ApplicationController

		def index
			res = Cloudinary::Api.resources(resource: 'image', format: 'pdf', max_results: 500)
			@resources = res['resources']
			render 'demo/resources'
		end
		
		def new 
			render 'demo/new'
		end
		
		def show 
			
			render 'show'
		end
	
		def new_upload
			file = params["file"]
			Cloudinary::Uploader.upload(file, :resource_type => :image,
			:public_id => params['file'].original_filename,
			:chunk_size => 6_000_000
			)
			@resource = file
			redirect_to 'show'
		end
		
		def pdfs
			res = Cloudinary::Api.resources(resource: 'image', format: 'pdf', max_results: 500)
			@pdfs = res['resources'].select{|r|r["format"]== 'pdf'}
			render 'demo/pdfs'
		end
	
		private
	
		def local_image_path(name)
			Rails.root.join('uploads', name).to_s
		end
	
	end
	

end
