class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # JTIMatcher
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist
  has_many :user_groups
  has_many :groups, through: :user_groups
  has_many :transactions
  validates_presence_of :name, :phone, :password
  def email_required?
    false
  end

  def as_json (options={})
    super(methods: %i[user_overall_balance user_group_balance])
  end
  
  def user_overall_balance
    transactions.reduce(0) do |sum, transaction|
      sum += transaction[:amount]
      sum
    end
  end

  def user_group_balance
    transactions.reduce(Hash.new(0)) do |sum, transaction|
      group_id = transaction[:group_id]
      sum[group_id] += transaction[:amount]
      sum
    end
  end
end
