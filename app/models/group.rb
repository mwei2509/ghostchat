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
  validates :expires_in, numericality: {:greater_than => 0, :less_than_or_equal_to => 1440}

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

  def set_expiration
    self.expiration = Time.now + self.expires_in.to_i.minutes
  end

  def self.check_expired
    Group.where('expiration < ?', Time.now).destroy_all
  end

  def random_title
    randtitle = RandomNouns.sample
    until !Group.pluck(:title).include? randtitle do
      randtitle = RandomNouns.sample
    end
    self.title=randtitle
  end

end
