class CreateViewers < ActiveRecord::Migration[6.0]
  def change
    create_table :viewers do |t|
      t.references :user, null: false, foreign_key: true
      t.boolean :idea, default: false
      t.boolean :survey, default: false
      t.boolean :project, default: false
      t.boolean :call_for_idea, default: false
      t.boolean :actuality, default: false
      t.integer :wys_id, null: false, default: 0

      t.timestamps
    end
  end
end
