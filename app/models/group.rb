class Group < ApplicationRecord
  validates :name, presence: true
  validates :icon, presence: true

  belongs_to :users, class_name: 'User', foreign_key: 'author_id'

  has_and_belongs_to_many :expenses, dependent: :destroy

  has_one_attached :icon
end
