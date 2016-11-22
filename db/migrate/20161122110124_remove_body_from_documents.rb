class RemoveBodyFromDocuments < ActiveRecord::Migration[5.0]
  def change
    change_table :documents do |t|
      t.remove :body
      t.string :title
    end
  end
end
