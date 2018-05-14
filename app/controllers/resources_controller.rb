class ResourcesController < ApplicationController

	def index
		res = Cloudinary::Api.resources(resource: 'image', format: 'pdf', max_results: 500)
		@resources = res['resources']
		render 'resources/resources'
	end
	
	def new 
		render 'resources/new'
	end
	
	def new_upload
		file = params["file"]
		Cloudinary::Uploader.upload(
			file, 
			:resource_type => :image,
			:public_id => params['file'].original_filename,
			:chunk_size => 6_000_000
		)
		@resource = file
		redirect_to 'show'
	end
	
	def destroy
		Cloudinary::Api.delete_resources(public_ids: params[:public_id])
		# DELETE /resources/image/upload?public_ids[]=image1&public_ids[]=image2
		redirect_to '/resources/destroy_confirmation'
	end

	def pdfs
		res = Cloudinary::Api.resources(resource: 'image', format: 'pdf', max_results: 500)
		@pdfs = res['resources'].select{|r|r["format"]== 'pdf'}
		render 'resources/pdfs'
	end
	
	def images
		res = Cloudinary::Api.resources(resource: 'image', format: 'image', max_results: 500)
		@images = res['resources'].select{|r| ['jpg', 'png', 'bmp'].include?(r["format"])}
		render 'resources/images'
	end

	private
	def local_image_path(name)
		Rails.root.join('uploads', name).to_s
	end
end
