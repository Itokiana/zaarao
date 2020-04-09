class AddFileToIdeas < ActiveRecord::Migration[6.0]
  def change
    add_column :ideas, :file, :string
  end
end
