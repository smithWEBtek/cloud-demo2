Rails.application.routes.draw do
  # resources :resources, only: [:index, :new, :create, :destroy]
	root to: 'resources#index'
 
	resources :resources, only: [:index, :show, :new, :create]

	get 'cloudinary_index', to: 'resources#cloudinary_index'

	get 'pdfs', to: 'resources#pdfs'
	get 'images', to: 'resources#images'
	get 'new', to: 'resources#new'
	post '/new_upload', to: 'resources#new_upload'

	get 'load_resources', to: 'resources#load_resources'
 
	get '/destroy', to: 'resources#destroy'
	get '/confirm_destroy', to: 'resources#confirm_destroy'
end
