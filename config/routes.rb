Rails.application.routes.draw do
	root 'posts#index'
  
	get    '/me',           to: 'users#show'
	get    '/users/:id',    to: 'users#show'
	get    '/login',        to: 'users#login'
	post   '/signup',	      to: 'users#create'
	post   '/login',     	  to: 'sessions#create'
	delete '/logout',       to: 'sessions#destroy'
	get    '/submit',       to: 'posts#new'
	post   '/submit',       to: 'posts#create'
	get    '/posts',        to: 'posts#index'
	get    '/posts/:id',    to: 'posts#show'
	get    '/comments/:id', to: 'comments#show'
	post   '/comments/new', to: 'comments#create'
end
