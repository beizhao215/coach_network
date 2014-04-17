class Group < ActiveRecord::Base
  belongs_to :coach
  has_many :enrollments, dependent: :destroy
  has_many :posts, dependent: :destroy
  
  searchable do
    text :name
  end
  
  validates :coach_id, presence: true
  validates :name, presence: true
  validates :description, presence: true
  
end
