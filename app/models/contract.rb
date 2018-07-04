class Contract < ApplicationRecord
  has_many :user_contracts, dependent: :destroy
  has_many :users, through: :user_contracts
end
