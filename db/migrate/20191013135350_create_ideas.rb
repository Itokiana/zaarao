class CreateIdeas < ActiveRecord::Migration[6.0]
  def change
    create_table :ideas do |t|
      t.belongs_to :admin, null: false, index: true
      t.references :space, null: false, foreign_key: true
      t.references :type,  null: false, foreign_key: true
      t.string :name, 		 null: false, default: ""
      t.text :description, null: false, default: ""
      t.boolean :ready, 	 							default: false
      t.belongs_to :call_for_idea,      index: true
      t.boolean :on, default: true

      t.timestamps
    end
  end
end
