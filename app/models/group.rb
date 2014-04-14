class Group < ActiveRecord::Base
  belongs_to :coach
  validates :coach_id, presence: true
  validates :name, presence: true
  validates :description, presence: true
  
end
