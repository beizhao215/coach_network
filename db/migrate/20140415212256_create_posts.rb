class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :content
      t.integer :coach_id
      t.integer :student_id
      t.integer :group_id

      t.timestamps
    end
    add_index :posts, [:created_at]
    
  end
end
