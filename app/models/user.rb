class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :subscription_choice, presence: true
  validates :name, presence: true
  has_many :keys
end
