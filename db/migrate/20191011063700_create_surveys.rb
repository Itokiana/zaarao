class CreateSurveys < ActiveRecord::Migration[6.0]
  def change
    create_table :surveys do |t|
      t.belongs_to :admin, null: false, index: true
      t.references :space, null: false, foreign_key: true
      t.references :type,  null: false, foreign_key: true
      t.string :name
      t.text :description
      t.datetime :end_date
      t.boolean :ready, default: false

      t.timestamps
    end
  end
end
