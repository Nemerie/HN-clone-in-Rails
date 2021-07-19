Rails.application.routes.draw do
  # Add a root route if you don't have one...
	# We can use users#new for now, or replace this with the controller and action you want to be the site root:
	root to: 'users#new'
  	
  	# sign up page with form:
	get 'users/new' => 'users#new', as: :new_user
	
	# create (post) action for when sign up form is submitted:
	post 'users' => 'users#create'
end
