class CompanyException
	include Mongoid::Document
	include Mongoid::Timestamps

	field :exception_backtrace, type: Array
	field :exception_message, type: String

	belongs_to :company
	belongs_to :user

	default_scope desc(:created_at)

end
