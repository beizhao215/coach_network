class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.integer :coach_id
      t.string :description

      t.timestamps
    end
    add_index :groups, [:coach_id]
  end
end
