class Group < ApplicationRecord
  has_secure_password

  has_many :users, dependent: :destroy
  has_one :creator, class_name: "User", dependent: :destroy

  accepts_nested_attributes_for :creator

  has_many :messages, dependent: :destroy
  before_validation :sanitize, :slugify

  def to_param
    self.slug
  end

  def slugify
    self.slug = self.title.downcase.gsub(" ", "-")
  end

  def sanitize
    self.title = self.title.strip
  end
end
