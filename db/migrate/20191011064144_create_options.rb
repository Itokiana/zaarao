class CreateOptions < ActiveRecord::Migration[6.0]
  def change
    create_table :options do |t|
      t.references :question, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
