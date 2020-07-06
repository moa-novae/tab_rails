class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # JTIMatcher
  devise :database_authenticatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist
  has_many :user_groups
  has_many :groups, through: :user_groups
  has_many :transactions
  validates_presence_of :name, :phone
end
