class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.belongs_to :admin, null: false, index: true
      t.references :space, null: false, foreign_key: true
      t.string :name
      t.text :description
      t.references :type, null: false, foreign_key: true
      t.datetime :deadline, null: false
      t.boolean :ready, default: false

      t.timestamps
    end
  end
end
