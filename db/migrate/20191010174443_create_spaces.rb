class CreateSpaces < ActiveRecord::Migration[6.0]
  def change
    create_table :spaces do |t|
      t.belongs_to :admin, index: true
      t.string :name, 		 null: false, default: ""
      t.text :description, null: false, default: ""
      t.boolean :private,      default: false
      t.boolean :discoverable, default: true

      t.timestamps
    end
  end
end
