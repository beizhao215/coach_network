class Group < ActiveRecord::Base
  belongs_to :coach
  has_many :enrollments, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :ratings, dependent: :destroy
  
  searchable do
    text :name
  end
  
  validates :coach_id, presence: true
  validates :name, presence: true
  validates :description, presence: true
  
  def average_rating
    if ratings.size != 0 
      ratings.sum(:score) / ratings.size
    else
      0
    end
  end
  
end
