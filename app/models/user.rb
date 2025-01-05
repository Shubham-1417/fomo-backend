class User < ApplicationRecord
    # Adds methods to set and authenticate against a bcrypt password.
    has_secure_password
  
    # Validations for user attributes
    validates :pseudonym, presence: true, uniqueness: true
    validates :password, presence: true, length: { minimum: 6 }
    validates :bio, length: { maximum: 200 }, allow_blank: true
  
    # Associations (if applicable)
    has_many :posts, dependent: :destroy
    has_many :comments, dependent: :destroy
  end
  