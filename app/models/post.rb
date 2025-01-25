class Post < ApplicationRecord
  # Associations
  belongs_to :user
  has_many :comments, dependent: :destroy

  # Tags association
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  # Validations
  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true
  validates :scope, presence: true, inclusion: { in: %w[global university region], message: "%{value} is not a valid scope" }
end
