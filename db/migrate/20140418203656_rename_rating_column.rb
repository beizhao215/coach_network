class RenameRatingColumn < ActiveRecord::Migration
  def change
    rename_column :ratings, :coach_id, :student_id
    
    
  end
end
