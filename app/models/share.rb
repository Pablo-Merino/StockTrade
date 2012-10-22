class Share
	include Mongoid::Document
	field :price, type: Money

	belongs_to :company
	belongs_to :user
	
	def amount
		1
	end

	def self.max(share_money, user_money)
		if share_money.cents == 0 or user_money.cents == 0
			logger.info "#{share_money}\n#{user_money}"
		else
			amount = (user_money.cents / share_money.cents).floor
		end
		
	end

end
