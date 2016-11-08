class AddInviteEmailToCollaborations < ActiveRecord::Migration[5.0]
  def change
    add_column :collaborations, :invite_email, :string
    add_index :collaborations, [:invite_email, :share_type, :share_id], unique: true, name: "index_collaborations_unique_invite_email"
  end
end
