class Group < ApplicationRecord
  attr_accessor :expires_in
  has_secure_password validations: false

  has_many :users, dependent: :destroy
  # has_one :creator, class_name: "User", dependent: :destroy

  # accepts_nested_attributes_for :creator
  # accepts_nested_attributes_for :users
  # validates_associated :creator, on: :create

  has_many :messages, dependent: :destroy

  validates :title, presence: true, uniqueness: true

  before_validation :sanitize, :slugify
  before_create :set_expiration

  def to_param
    self.slug
  end

  def slugify
    self.slug = self.title.downcase.gsub(" ", "-")
  end

  def sanitize
    self.title = self.title.strip
  end

  # def set_expiration(min)
  #   if Time.strptime(self.expiration.to_s, '%s') < Time.now
  #     self.expiration = Time.now + min.to_i.minutes
  #   else
  #     self.expiration = self.expiration + min.to_i.minutes
  #   end
  # end

  def set_expiration
    self.expiration = Time.now + self.expires_in.to_i.minutes
  end

end
