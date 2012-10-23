class DashboardController < ApplicationController
	before_filter :authenticate_user!
	def index
		@companies = current_user.shares.map { |s| s.company }.uniq
		@transactions = current_user.transactions.paginate(:page => params[:transactions_page], :per_page => 5)
	end

	def show
		@user = User.find_by(:username => params[:id])
		@companies = @user.shares.map { |s| s.company }.uniq
		@wealth = 0
		@user.shares.map {|s| @wealth += s.price.cents }
	end
end
