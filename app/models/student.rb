class Student < ActiveRecord::Base
  has_many :enrollments, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :ratings, dependent: :destroy
  
  
  
  before_save { self.email = email.downcase }
  before_create :create_remember_token
  
  
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
                    format: { with: VALID_EMAIL_REGEX }, 
                    uniqueness: { case_sensitive: false }
  validate :unique_email
  has_secure_password
  validates :password, length: { minimum: 6 }
                    
  def unique_email
    self.errors.add(:email, "is already taken") if Coach.where(email: self.email).exists?
  end
  
  def Student.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def Student.hash(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  
  def enroll!(group)
    enrollments.create!(group_id:group.id)
  end
  
  def enrolling?(group)
    enrollments.find_by(group_id:group.id)
  end
  
  def drop!(group)
    enrollments.find_by(group_id:group.id).destroy
  end

  private

    def create_remember_token
      self.remember_token = Student.hash(Student.new_remember_token)
    end
end
