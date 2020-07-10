class Transaction < ApplicationRecord
  belongs_to :group
  belongs_to :user
  validates_presence_of :amount, :user_id, :group_id
end
