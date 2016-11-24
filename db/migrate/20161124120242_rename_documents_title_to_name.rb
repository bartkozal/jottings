class RenameDocumentsTitleToName < ActiveRecord::Migration[5.0]
  def change
    rename_column :documents, :title, :name
  end
end
