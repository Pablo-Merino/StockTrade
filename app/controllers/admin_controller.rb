class AdminController < ApplicationController
	before_filter :check_admin

	def index
		@money_spent = Transaction.where(:type => :buy).all.entries.map { |t| t.amount.cents }.inject(:+)
		@money_won = Transaction.where(:type => :sell).all.entries.map { |t| t.amount.cents }.inject(:+)
		@money_moved = Transaction.all.entries.map { |t| t.amount.cents }.inject(:+)
	end

	def users
		@users = User.paginate(:page => params[:page], :per_page => 5)
	end

	def companies
		@companies = Company.paginate(:page => params[:page], :per_page => 5)
	end

	# COMPANIES METHODS

	def new_company
		@company = Company.new(params[:company])
		if @company.save
			redirect_to :back, :notice => "Created succesfully"
		else
			redirect_to :back, :alert => "Error creating!"
		end
	end

	def destroy_company
		@company = Company.find_by(slugged_symbol: params[:id])
		if @company.destroy
			redirect_to :back, :notice => "Destroyed succesfully"
		else
			redirect_to :back, :alert => "Error destroying!"
		end
	end

	def update_company_shares
		Company.update_shares
		redirect_to :back, :notice => "Shares updated succesfully"
	end

	def edit_company
		@company = Company.find_by(slugged_symbol: params[:id])
	end

	def update_company
		@company = Company.find_by(slugged_symbol: params[:id])
		if @company.update_attributes(params[:company])
			redirect_to admin_companies_path, :notice => "Updated succesfully"
		else
			redirect_to admin_companies_path, :alert => "Error updating!"
		end
	end

	# USERS METHODS

	def set_money
		@user = User.find_by(username: params[:id])
		@user.money = Money.new params[:user][:money].to_i
		if params[:user][:money].to_i < 0
			redirect_to :back, :alert => "Negative money!? What in the world?!"
		else
			if @user.save
				redirect_to :back, :notice => "Updated succesfully"
			else
				redirect_to :back, :alert => "Error updating!"
			end
		end
	end

	def destroy_user
		@user = User.find_by(username: params[:id])

		if @user.destroy
			redirect_to :back, :notice => "Destroyed succesfully"
		else
			redirect_to :back, :alert => "Error destroying!"
		end
	end

	def toggle_admin
		@user = User.find_by(username: params[:id])

		if @user.admin
			@user.admin = false
		elsif !@user.admin
			@user.admin = true
		end

		if @user.save
			redirect_to :back, :notice => "Updated succesfully"
		else
			redirect_to :back, :alert => "Error updating!"
		end
	end


	def check_admin
		if :authenticate_user! and current_user.admin
			true
		else
			redirect_to root_path
		end
	end

	def exceptions_index
		@exceptions = CompanyException.paginate(:page => params[:page], :per_page => 5)
	end

	def exceptions_show
		@exception = CompanyException.find(params[:id])
	end

end
