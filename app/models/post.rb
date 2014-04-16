class Post < ActiveRecord::Base
  belongs_to :coach
  belongs_to :student
  belongs_to :group
  
  default_scope -> { order('created_at DESC') }
  
  validates :content, presence: true, length: { maximum: 140 }
  validates_presence_of :coach_id, :unless => :student_id?
  validates_presence_of :student_id, :unless => :coach_id?
  validates :group_id, presence: true
end
