class Group < ApplicationRecord
  has_many :user_groups
  has_many :users, through: :user_groups
  has_many :transactions
  validates_presence_of :name
end
