class CreateCollaborations < ActiveRecord::Migration[5.0]
  def change
    change_table :documents do |t|
      t.remove :user_id
      t.belongs_to :owner
    end

    create_table :collaborations do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :document, foreign_key: true
      t.timestamps null: false
    end
  end
end
