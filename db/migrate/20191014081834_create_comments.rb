class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.belongs_to :user, default: false
      t.boolean :idea, default: false
      t.boolean :project, default: false
      t.integer :wyc_id, null: false
      t.text :content

      t.timestamps
    end
  end
end
