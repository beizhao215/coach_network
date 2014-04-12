class Group < ActiveRecord::Base
  validates :coach_id, presence: true
end
