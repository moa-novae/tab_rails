class User < ApplicationRecord
  has_many :user_groups
  has_many :groups, through: :user_groups
  has_many :transactions
  validates_presence_of :name, :phone
end
