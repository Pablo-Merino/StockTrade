StockTrade::Application.routes.draw do

	# OTHER ROUTES
	root :to => 'system/static#index'
	get '/about' => 'system/static#about', :as => 'about'

	# ADMIN PANEL
  	# get "/admin" => 'admin#index', :as => 'admin'
  	# put "/admin/:id/set_money" => 'admin#set_money', :as => 'admin_set_money'
  	# delete "/admin/:id/destroy" => 'admin#destroy_user', :as => 'admin_destroy_user'

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
