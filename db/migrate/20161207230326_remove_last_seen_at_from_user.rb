class RemoveLastSeenAtFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :last_seen_at
  end
end
