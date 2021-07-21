Rails.application.routes.draw do
	root 'users#show'
  
	get    '/me',     to: 'users#show'
	get    '/login',  to: 'users#login'
	post   '/signup', to: 'users#create'
	post   '/login',  to: 'sessions#create'
	delete '/logout', to: 'sessions#destroy'
	get    '/logout', to: 'sessions#destroy' # TODO: remove
end
