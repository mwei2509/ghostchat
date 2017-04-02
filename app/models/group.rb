class Group < ApplicationRecord
  has_secure_password

  has_many :users, dependent: :destroy
  has_one :creator, class_name: "User", dependent: :destroy

  accepts_nested_attributes_for :creator

  has_many :messages, dependent: :destroy
  before_validation :sanitize, :slugify
  before_create :default_expiration

  def to_param
    self.slug
  end

  def slugify
    self.slug = self.title.downcase.gsub(" ", "-")
  end

  def sanitize
    self.title = self.title.strip
  end

  def set_expiration(min)
    if Time.strptime(self.expiration.to_s, '%s') < Time.now
      self.expiration = Time.now + min.to_i.minutes
    else
      self.expiration = self.expiration + min.to_i.minutes
    end
  end

  def default_expiration
    self.expiration = Time.now + 1.minutes
  end

end
