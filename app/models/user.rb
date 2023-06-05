class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true

  has_many :groups, foreign_key: 'author_id'
  has_many :expenses, foreign_key: 'author_id'
end
