class CreateJoinTableUsersActivities < ActiveRecord::Migration[6.0]
  def change
    create_join_table :users, :activities do |t|
      t.index :user_id
      t.index :activity_id
    end
  end
end
