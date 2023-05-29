# frozen_string_literal: true

class CreateExpensesGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :expenses_groups do |t|
      t.references :expenses, null: false, foreign_key: true
      t.references :groups, null: false, foreign_key: true

      t.timestamps
    end
  end
end
