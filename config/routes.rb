Rails.application.routes.draw do
  resources :resources
	root :to => 'resources#index'
	get '/resources', to: 'resources#index'
	get 'pdfs', to: 'resources#pdfs'
	get 'images', to: 'resources#images'
	get 'new', to: 'resources#new'
	post '/new_upload', to: 'resources#new_upload'
end
