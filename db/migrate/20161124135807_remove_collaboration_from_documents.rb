class RemoveCollaborationFromDocuments < ActiveRecord::Migration[5.0]
  def change
    change_table :collaborations do |t|
      t.remove_references :share, polymorphic: true
      t.belongs_to :stack
    end

    change_table :documents do |t|
      t.remove_references :owner
      t.foreign_key :stacks
    end
  end
end
