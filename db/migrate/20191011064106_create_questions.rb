class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.references :survey, null: false, foreign_key: true
      t.string :name
      t.boolean :mcq

      t.timestamps
    end
  end
end
