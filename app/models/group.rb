class Group < ApplicationRecord
  validates :name, presence: true, length: { maximum: 25 }
  validates :icon, presence: true

  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  has_and_belongs_to_many :expenses, dependent: :destroy

  has_one_attached :icon
end
