class CreateActualities < ActiveRecord::Migration[6.0]
  def change
    create_table :actualities do |t|
    	t.belongs_to :admin, null: false, index: true
      t.references :space, null: false, foreign_key: true
      t.string :name,  		 null: false, default: ""
      t.text :description, null: false, default: ""

      t.timestamps
    end
  end
end
