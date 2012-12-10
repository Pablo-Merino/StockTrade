class CompaniesController < ApplicationController
	before_filter :authenticate_user!, :except => [:index, :show, :search_gateway, :search]
	def index
		@companies = Company.paginate(:page => params[:page], :per_page => 20)

	end

	def show
		begin
			require 'yahoo_stock'

			@company = Company.find_by(slugged_symbol: params[:id])
			raise Mongoid::Errors::DocumentNotFound.new(Company, slug: params[:id]) if @company.nil?

			@articles = Feedzirra::Feed.fetch_and_parse("http://finance.yahoo.com/rss/headline?s=#{@company.slugged_symbol}").entries

			stock_history = YahooStock::History.new(:stock_symbol => @company.slugged_symbol, :start_date => Date.today-50, :end_date => Date.today-1).results(:to_array).output
			@history = stock_history.map { |h| h[3] }

			@yesterday_stats = stock_history.last

		rescue YahooStock::Interface::InterfaceError => e
			@exception = CompanyException.new(:exception_backtrace => e.backtrace, :exception_message => e.message)
			@exception.company = @company
			@exception.user = current_user
			@exception.save
			render 'errors/internal_server_error', :status => 500
		rescue Mongoid::Errors::DocumentNotFound
			render 'errors/not_found', :status => 404
		end
	end

	def buy

		@company = Company.find_by(slugged_symbol: params[:id])
		amount = params[:share][:amount].to_i

		if amount >= 1

			money_spent = @company.share_price.cents * amount

			if money_spent > current_user.money.cents
				redirect_to :back, :alert => "You don't have that money!"
			else
				amount.times do |t|
					share = Share.new(:price => @company.share_price)
					share.company = @company
					share.user = current_user
					share.save
				end


				transaction = Transaction.new(:amount => Money.new(money_spent), :type => :buy, :shares_amount => amount, :user_money_before => current_user.money)

				current_user.transactions << transaction
				transaction.user = current_user
				transaction.company = @company



				current_user.money = current_user.money - Money.new(money_spent)

				transaction.user_money_after = current_user.money

				current_user.save
				transaction.save 

				redirect_to :back, :notice => "Bought #{amount} shares!"
			end
		else
			redirect_to :back, :alert => "You can't buy less than 1 share!"
		end


	end

	def sell

		@company = Company.find_by(slugged_symbol: params[:id])
		amount = params[:share][:amount].to_i
		user_shares = current_user.shares.where(company: @company).count
		if amount >= 1
			if amount > user_shares
				redirect_to :back, :alert => "You don't have that number of shares!"
			else
				money_won = @company.share_price.cents * amount
				@count = 0
				current_user.shares.each do |s|
					@c_shares = []
					if s.company == @company
						@c_shares << s
					end
					
					@c_shares.each do |s|
						s.destroy if @count < amount
						@count = @count + 1
					end
				end

				transaction = Transaction.new(:amount => Money.new(money_won), :type => :sell, :shares_amount => amount, :user_money_before => current_user.money)

				current_user.transactions << transaction
				transaction.user = current_user
				transaction.company = @company



				current_user.money = current_user.money + Money.new(money_won)

				transaction.user_money_after = current_user.money

				current_user.save
				transaction.save 

				redirect_to :back, :notice => "Sold #{amount} #{amount == 1 ? 'share' : 'shares'}!"
			end
		else
			redirect_to :back, :alert => "You can't sell less than 1 share!"
		end
	end

	def search_gateway
		redirect_to search_path(params[:company][:search])
	end

	def search
		@companies = Company.where(:name => Regexp.new(/#{params[:id]}/i), :symbol => Regexp.new(/#{params[:id]}/i)).paginate(:page => params[:page], :per_page => 20)
		render 'index'
	end
end
