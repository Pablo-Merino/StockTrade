class System::StaticController < ApplicationController
	def index
		if user_signed_in?
			redirect_to dashboard_path
		end
	end
	
	def about
	end
end
