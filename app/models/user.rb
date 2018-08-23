class User < ActiveRecord::Base
  has_many :customers
  has_many :user_sells
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :first_name, presence: true
  validates :last_name, presence: true
  enum user_type: {admin: 100, author: 50, sub: 10}
end
