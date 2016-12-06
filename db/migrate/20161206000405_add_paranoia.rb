class AddParanoia < ActiveRecord::Migration[5.0]
  def change
    add_column :documents, :deleted_at, :datetime
    add_index :documents, :deleted_at

    add_column :stacks, :deleted_at, :datetime
    add_index :stacks, :deleted_at

    add_column :collaborations, :deleted_at, :datetime
    add_index :collaborations, :deleted_at
  end
end
