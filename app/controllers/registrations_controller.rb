class RegistrationsController < Devise::RegistrationsController
	def new
		
		if params[:code] != "3wdt7bpc"
			redirect_to root_path, :alert => 'Wrong invite code'
		else
			super
		end
	end

	def create
		super
		
	end

	def update
		super
	end
end
