class AddLastSeenAtToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :last_seen_at, :datetime
  end
end
