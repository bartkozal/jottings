class CreateNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :notes do |t|
      t.belongs_to :user, foreign_key: true
      t.text :body
      t.string :title
      t.timestamps null: false
    end
  end
end
