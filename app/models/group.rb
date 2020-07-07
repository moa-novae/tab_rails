class Group < ApplicationRecord
  has_many :user_groups
  has_many :users, through: :user_groups
  has_many :transactions
  validates_presence_of :name

  def as_json(options={})
    super(include: %i[users transactions],
          methods: :user_balance
    )
  end

  def user_balance
    transactions.reduce(Hash.new(0)) do |sum, transaction|
      user_id = transaction[:user_id]
      sum[user_id] += transaction[:amount]
      sum
    end
  end
end
