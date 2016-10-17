class RemoveTitleFromDocuments < ActiveRecord::Migration[5.0]
  def change
    change_table :documents do |t|
      t.remove :title
    end
  end
end
