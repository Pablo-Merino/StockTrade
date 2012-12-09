StockTrade::Application.routes.draw do

	# OTHER ROUTES
	root :to => 'system/static#index'
	get '/about' => 'system/static#about', :as => 'about'

	# ADMIN PANEL
	scope "/admin" do
  		get "/" => 'admin#index', :as => 'admin'
	  	get "/users" => 'admin#users', :as => 'admin_users'
	  	get "/companies" => 'admin#companies', :as => 'admin_companies'
	  	get "/company/:id" => 'admin#edit_company', :as => 'admin_edit_company'

  		# ADMIN COMPANIES
	  	post "/companies/new" => 'admin#new_company', :as => "admin_new_company"
	  	delete "/companies/:id/destroy" => 'admin#destroy_company', :as => "admin_destroy_company", :constraints => { :id => /[^\/]+/}
	  	put "/companies/update_shares" => 'admin#update_company_shares', :as => "admin_update_company_shares"
		put "/company/:id/update" => 'admin#update_company', :as => 'admin_update_company'
		
	  	# ADMIN USERS
	  	put "/users/:id/set_money" => 'admin#set_money', :as => 'admin_set_money'
	  	delete "/users/:id/destroy" => 'admin#destroy_user', :as => 'admin_destroy_user'

	  	put "/users/:id/toggle_admin" => 'admin#toggle_admin', :as => 'admin_toggle_admin'

	  	get '/exceptions' => 'admin#exceptions_index', :as => 'admin_exceptions_index'
	  	get '/exceptions/:id' => 'admin#exceptions_show', :as => 'admin_exceptions_show'
	end

	# LEADERBOARDS
  	get "/leaderboards" => 'leaderboards#index', :as => 'leaderboards'

	# PORFOLIOS
	scope '/portfolio' do
		get '/' => 'dashboard#index', :as => 'dashboard'
		get '/:id' => 'dashboard#show', :as => 'user'
	end

	# COMPANIES
	scope '/companies' do
		get '/' => 'companies#index', :as => 'companies'
		get '/:id' => 'companies#show', :as => 'company', :constraints => { :id => /[^\/]+/}
		put '/:id/buy' => 'companies#buy', :as => 'buy_shares', :constraints => { :id => /[^\/]+/}
		delete '/:id/sell' => 'companies#sell', :as => 'sell_shares', :constraints => { :id => /[^\/]+/}
		post '/search' => 'companies#search_gateway', :as => 'search_gateway'
		get '/search/:id' => 'companies#search', :as => 'search'
	end

	# USER DEVISE
	devise_for :users, :controllers => {:registrations => "registrations"}

end
