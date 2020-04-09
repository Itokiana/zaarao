class CreateCallForIdeas < ActiveRecord::Migration[6.0]
  def change
    create_table :call_for_ideas do |t|
      t.belongs_to :project, null: false, index: true
      t.belongs_to :type, 	 null: false, index: true
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
