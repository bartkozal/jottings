class CreateStacks < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key :collaborations, :documents

    change_table :collaborations do |t|
      t.remove_belongs_to :document
      t.belongs_to :share, polymorphic: true
    end

    change_table :documents do |t|
      t.belongs_to :stack
    end

    create_table :stacks do |t|
      t.string :name
      t.belongs_to :owner
      t.timestamps null: false
    end
  end
end
