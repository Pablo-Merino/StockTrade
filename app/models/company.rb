class Company
	include Mongoid::Document
	field :name, type: String
	field :symbol, type: String
	field :slugged_symbol, type: String

	field :share_price,					:type => Money
	field :old_share_price,				:type => Money

	validates_uniqueness_of :symbol

	has_many :shares
	has_many :transactions

	default_scope desc(:share_price)

	before_save :set_slugged_symbol

	def self.update_shares
		require 'csv'
		response = HTTParty.get('http://www.nasdaq.com/screening/companies-by-industry.aspx?render=download').body

		CSV.parse(response) do |row|
			unless Money.parse(row[2].strip).cents == 0
				c = Company.find_or_create_by(symbol:row[0].strip)
				
				c.name = row[1].strip
							
				c.share_price = Money.parse(row[2].strip)	
				c.old_share_price = Money.parse(row[2].strip)	
				

				c.save
			end
				
		end
	end

	def to_param
		self.slugged_symbol
	end

	def update_values

		quote = YahooStock::Quote.new(:stock_symbols => self.symbol)
			
		self.share_price = Money.parse(quote.results(:to_array).output[0][1].to_s)

	end

	def set_slugged_symbol
		self.symbol =~ /(.*)(\/|\^)/
		new_symbol = $1
		if new_symbol.nil?
			self.slugged_symbol = self.symbol.gsub("^", "").gsub("/", "").strip	
		else
			if self.symbol == "BRK/A"
				self.slugged_symbol = "BRK-A"
			elsif self.symbol == "C/WS/B"
				self.slugged_symbol = "C"
			else
				self.slugged_symbol = new_symbol.gsub("^", "").gsub("/", "").strip
			end
		end
	end


end
