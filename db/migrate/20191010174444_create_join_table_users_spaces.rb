class CreateJoinTableUsersSpaces < ActiveRecord::Migration[6.0]
  def change
    create_join_table :users, :spaces do |t|
      t.index :user_id
      t.index :space_id
    end
  end
end
