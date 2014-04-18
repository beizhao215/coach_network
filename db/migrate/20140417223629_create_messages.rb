class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :title
      t.string :content
      t.integer :student_id
      t.integer :coach_id

      t.timestamps
    end
    add_index :messages, :student_id
    add_index :messages, :coach_id
  end
end
