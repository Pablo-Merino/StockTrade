class User
	include Mongoid::Document
	include Mongoid::Timestamps

	# Include default devise modules. Others available are:
	# :token_authenticatable, :confirmable,
	# :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
		:recoverable, :rememberable, :trackable, :validatable
	attr_protected :admin
	## Database authenticatable
	field :email,				:type => String, :default => ""
	field :encrypted_password,	:type => String, :default => ""

	field :username,			:type => String

	field :money,				:type => Money, :default => Money.new(2000000)

	field :admin,				:type => Boolean, :default => false

	validates_presence_of :email
	validates_presence_of :username
	validates_presence_of :encrypted_password
	validates_uniqueness_of :username

	## Recoverable
	field :reset_password_token,   :type => String
	field :reset_password_sent_at, :type => Time

	## Rememberable
	field :remember_created_at, :type => Time

	## Trackable
	field :sign_in_count,      :type => Integer, :default => 0
	field :current_sign_in_at, :type => Time
	field :last_sign_in_at,    :type => Time
	field :current_sign_in_ip, :type => String
	field :last_sign_in_ip,    :type => String

	default_scope desc(:money)


	## Confirmable
	# field :confirmation_token,   :type => String
	# field :confirmed_at,         :type => Time
	# field :confirmation_sent_at, :type => Time
	# field :unconfirmed_email,    :type => String # Only if using reconfirmable

	## Lockable
	# field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
	# field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
	# field :locked_at,       :type => Time

	## Token authenticatable
	# field :authentication_token, :type => String

	has_many :shares
	has_many :transactions
	has_many :company_exceptions
	

	def current_money
		self.money
	end

	def to_param
		self.username
	end

end
