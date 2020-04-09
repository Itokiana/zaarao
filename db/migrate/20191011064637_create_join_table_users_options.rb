class CreateJoinTableUsersOptions < ActiveRecord::Migration[6.0]
  def change
    create_join_table :users, :options do |t|
      t.index :user_id
      t.index :option_id
    end
  end
end
