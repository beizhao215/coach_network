class Message < ActiveRecord::Base
  belongs_to :student
  belongs_to :coach
  
  validates :title, presence: true
  validates :content, presence: true
  validates :student_id, presence: true
  validates :coach_id, presence: true
  
end
