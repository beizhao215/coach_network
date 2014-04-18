class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.references :group, index: true
      t.references :student, index: true
      t.integer :score, default: 0

      t.timestamps
    end
  end
end
