class Comment < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :post

  # Validations
  validates :content, presence: true, length: { maximum: 300 }
end
