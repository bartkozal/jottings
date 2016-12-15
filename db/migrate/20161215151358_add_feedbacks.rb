class AddFeedbacks < ActiveRecord::Migration[5.0]
  def change
    enable_extension :hstore

    create_table :feedbacks do |t|
      t.belongs_to :user
      t.hstore :answers
      t.text :comment
      t.string :ip
      t.timestamps null: false
    end
  end
end
