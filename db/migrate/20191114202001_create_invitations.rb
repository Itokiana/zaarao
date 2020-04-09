class CreateInvitations < ActiveRecord::Migration[6.0]
  def change
    create_table :invitations do |t|
      t.bigint :sender_id
      t.bigint :recipient_id
      t.text :message
      t.boolean :accepted, 		 null: false, default: false
      t.boolean :declined, 		 null: false, default: false
      t.string :password_token

      t.timestamps
    end
    add_index :invitations, :password_token, unique: true
  end
end
