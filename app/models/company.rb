class Company
	include Mongoid::Document
	field :name, type: String
	field :symbol, type: String

	field :share_price,					:type => Money
	field :old_share_price,				:type => Money

	validates_uniqueness_of :symbol

	has_many :shares
	has_many :transactions

	before_save :update_values

	default_scope desc(:share_price)

	def self.update_shares
		require 'yahoo_stock'

		Company.all.entries.each do |c|
			quote = YahooStock::Quote.new(:stock_symbols => c.symbol)
					
			c.old_share_price = c.share_price
			c.share_price = Money.parse(quote.results(:to_array).output[0][1].to_s)

			c.save
		end
	end

	def to_param
		self.symbol
	end

	def update_values

		quote = YahooStock::Quote.new(:stock_symbols => self.symbol)
			
		self.share_price = Money.parse(quote.results(:to_array).output[0][1].to_s)

	end


end
