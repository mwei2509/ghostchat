class User < ApplicationRecord
  belongs_to :group, optional: true
  has_many :messages

  # has_secure_password validations: false
  # validates :password, presence: true, :if => :is_creator?
  validates :username, uniqueness: {scope: :group, case_sensitive: false}

  # private
  # def is_creator?
  #   is_creator == true
  # end
end
