class AddRootStack < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key :collaborations, :users
    add_foreign_key :collaborations, :stacks
    add_reference :stacks, :user, index: true
  end
end
