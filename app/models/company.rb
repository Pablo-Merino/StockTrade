class Company
	include Mongoid::Document
	field :name, type: String
	field :symbol, type: String

	field :share_price,				:type => Money

	has_many :shares
	has_many :transactions

	@queue = :update_share_queue


	def self.update_shares
		require 'yahoo_stock'
		companies = {
			:AAPL => 'Apple Inc. (NASDAQ)',
			:YHOO => 'Yahoo! Inc. (NASDAQ)',
			:MSFT => 'Microsoft Corporation (NASDAQ)',
			:FB => 'Facebook Inc. (NASDAQ)',
			:EBAY => 'eBay Inc. (NASDAQ)',
			:GOOG => 'Google Inc. (NASDAQ)',
			:AMZN => 'Amazon.com Inc. (NASDAQ)',
			:SIRI => 'Sirius XM Radio Inc. (NASDAQ)',
			:INTC => 'Intel Corporation (NASDAQ)',
			:CSCO => 'Cisco Systems Inc. (NASDAQ)',
			:"ADS.DE" => 'Adidas AG (DAX)',
			:"ALV.DE" => 'Allianz SE (DAX)',
			:"IFX.DE" => 'Infineon Technologies AG (DAX)',
			:"VOW3.DE" => 'Volkswagen AG (DAX)',
			:"BKIA.MC" => 'Bankia SA (MCE)',
			:"ELE.MC" => 'Endesa SA (MCE)',
			:"IBE.MC" => 'Iberdrola SA (MCE)',
			:"TEF.MC" => 'Telefonica SA (MCE)',
			:"ITX.MC" => 'INDITEX SA (MCE)',
			:"BSY.L" => 'British Sky Broadcasting Group plc (LSE)',
			:"BT-A.L" => 'BT Group plc (LSE)',
			:"HSBA.L" => 'HSBC Holdings plc (LSE)',
			:"BA.L" => 'BAE Systems plc (LSE)',
			:"BARC.L" => 'Barclays PLC (LSE)',
			:TWX => 'Time Warner Inc. (NYSE)',
			:GE => 'General Electrics Inc. (NYSE)',
			:F => 'Ford Motor Corporation (NYSE)',
			:GM => 'General Motors Company (NYSE)',
			:KRFT => 'Kraft Foods Group Inc. (NASDAQ)',
			:"VOD.L" => 'Vodafone Group plc (LSE)',
			:KO => 'The Coca-Cola Company (NYSE)',
			:PEP => 'Pepsico Inc. (NYSE)'
		}
		companies.each do |i, v|
			quote = YahooStock::Quote.new(:stock_symbols => i)
			c = Company.find_or_create_by(:symbol => i.to_s)
			
			c.name = v
			c.share_price = Money.parse(quote.results(:to_array).output[0][1].to_s)

			c.save
		end
	end

	def to_param
		self.symbol
	end

	def self.perform
		Company.update_shares
	end


end
