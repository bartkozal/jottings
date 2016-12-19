class AddOnlineUsersToDocuments < ActiveRecord::Migration[5.0]
  def change
    add_column :documents, :online_users, :string, array: true, null: false, default: []
  end
end
