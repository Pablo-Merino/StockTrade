class Transaction
	include Mongoid::Document
	include Mongoid::Timestamps
	field :amount,				type: Money
	field :type,				type: Symbol
	field :shares_amount,		type: Integer
	field :user_money_before,	type: Money
	field :user_money_after,	type: Money
	belongs_to :user
	belongs_to :company

	default_scope desc(:created_at)

end
