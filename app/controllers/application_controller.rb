class ApplicationController < ActionController::Base
	protect_from_forgery
	before_filter :update_shares
	def update_shares
		SHARE_UPDATER_QUEUE.push({})
	end


end
