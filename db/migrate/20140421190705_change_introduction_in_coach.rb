class ChangeIntroductionInCoach < ActiveRecord::Migration
  def change
    change_column :coaches, :self_introduction, :text
    change_column :coaches, :course_introduction, :text
    change_column :groups, :description, :text
    change_column :messages, :content, :text
    
    
    
  end
end
