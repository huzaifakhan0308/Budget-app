class Expense < ApplicationRecord
  validates :name, presence: true
  validates :amount, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  has_and_belongs_to_many :groups
end
