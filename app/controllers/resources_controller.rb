class ResourcesController < ApplicationController
	before_action :set_resource, only: [:show, :update, :destroy]

	def index
		data = Resource.load
		@cloud_resource_count = data["cloud_resource_count"]
		@db_resource_count = data["db_resource_count"]
		@resources = Resource.all.sort_by{|r| r.public_id}
	end

	def load_resources
		redirect_to '/resources'
	end

	def cloudinary_index
		res = Cloudinary::Api.resources(resource: 'image', format: 'pdf', max_results: 500)
		@resources = res['resources']
	end
	
	def show
	end
	
	def new 
		@resource = Resource.new
		render 'resources/new'
	end
	
	def create
		file =	Cloudinary::Uploader.upload(
			params["resource"]["file"], 
			:public_id => params["resource"]["file"].original_filename,
			:resource_type => :image,
			:chunk_size => 6_000_000
			)
 
			@resource = Resource.new(
				public_id: file["public_id"].gsub('.pdf', ''), 
				width: 	file["width"],
				height: file["height"],
				format: file["format"],
				url: file["url"],
				secure_url: file["secure_url"])

		# if @resource.save
		# 	redirect_to 'resources/show'
		# else 
			# redirect_to 'root_path'
			redirect_to 'cloudinary_index_path'
			# end
		end
		
		def destroy
			Cloudinary::Api.delete_resources(public_ids: params[:public_id])
			@resource = Resource.find_by_public_id(params["public_id"])
			redirect_to '/confirm_destroy'
	end

	def confirm_destroy
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
	def set_resource
		@resource = Resource.find_by_id(params["id"])
	end

	def resource_params
		params.require(:resource).permit(:public_id, :width, :height, :format, :url, :secure_url)
	end

	def local_image_path(name)
		Rails.root.join('uploads', name).to_s
	end
end
