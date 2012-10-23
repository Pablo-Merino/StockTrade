StockTrade::Application.routes.draw do

  get "admin/index"

	# OTHER ROUTES
	root :to => 'system/static#index'
	get '/about' => 'system/static#about', :as => 'about'

	# ADMIN PANEL
  	get "/admin" => 'admin#index', :as => 'admin'
  	get "/admin/users" => 'admin#users', :as => 'admin_users'
  	get "/admin/companies" => 'admin#companies', :as => 'admin_companies'
  	get "/admin/company/:id" => 'admin#edit_company', :as => 'admin_edit_company'

  	# ADMIN COMPANIES
  	post "/admin/companies/new" => 'admin#new_company', :as => "admin_new_company"
  	delete "/admin/companies/:id/destroy" => 'admin#destroy_company', :as => "admin_destroy_company", :constraints => { :id => /[^\/]+/}
  	put "/admin/companies/update_shares" => 'admin#update_company_shares', :as => "admin_update_company_shares"
	put "/admin/company/:id/update" => 'admin#update_company', :as => 'admin_update_company'
	
  	# ADMIN USERS
  	put "/admin/users/:id/set_money" => 'admin#set_money', :as => 'admin_set_money'
  	delete "/admin/users/:id/destroy" => 'admin#destroy_user', :as => 'admin_destroy_user'

  	put "/admin/users/:id/toggle_admin" => 'admin#toggle_admin', :as => 'admin_toggle_admin'

	# LEADERBOARDS
  	get "/leaderboards" => 'leaderboards#index', :as => 'leaderboards'

	# PORFOLIOS
	get '/portfolio' => 'dashboard#index', :as => 'dashboard'
	get '/portfolio/:id' => 'dashboard#show', :as => 'user'

	# COMPANIES
	get '/companies' => 'companies#index', :as => 'companies'
	get '/companies/:id' => 'companies#show', :as => 'company', :constraints => { :id => /[^\/]+/}
	put '/companies/:id/buy' => 'companies#buy', :as => 'buy_shares', :constraints => { :id => /[^\/]+/}
	delete '/companies/:id/sell' => 'companies#sell', :as => 'sell_shares', :constraints => { :id => /[^\/]+/}

	# USER DEVISE
	devise_for :users, :controllers => {:registrations => "registrations"}

end
