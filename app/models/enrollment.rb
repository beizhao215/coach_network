class Enrollment < ActiveRecord::Base
  belongs_to :group, class_name: "Group"
  belongs_to :student, class_name: "Student"
  validates :group_id, presence: true
  validates :student_id, presence: true
  
end
