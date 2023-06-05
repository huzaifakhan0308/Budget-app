class AddForeignReferences < ActiveRecord::Migration[7.0]
  def change
    add_reference :expenses, :groups, null: false, foreign_key: { to_table: :groups, on_delete: :cascade }
    add_reference :groups, :expenses, foreign_key: { to_table: :expenses }
  end
end
