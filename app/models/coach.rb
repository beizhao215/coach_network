class Coach < ActiveRecord::Base
  has_many :groups, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_attached_file :photo, styles: { small: "300x300>" }
  
  
  before_save { self.email = email.downcase }
  before_create :create_remember_token
  after_save    :expire_contact_all_cache
  after_destroy :expire_contact_all_cache 
  
  validates :name, presence: true, length: { maximum:50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
                    format: { with: VALID_EMAIL_REGEX }, 
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum:6 }
  validates_attachment :photo, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }
  validates_attachment_size :photo, :less_than => 1.megabytes
  
  
  
  def Coach.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def Coach.hash(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = Coach.hash(Coach.new_remember_token)
    end

    def self.all_cached
      Rails.cache.fetch('Coach.all') { all }
    end

    def expire_contact_all_cache
      Rails.cache.delete('Coach.all')
    end
end
