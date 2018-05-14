class Article < ApplicationRecord
  belongs_to :user
  # presence -> Must not be nil
  # length -> must be of length x
  validates :title, presence: true, length: {minimum: 5, maximum: 50}
  validates :description, presence: true, length: {minimum: 10, maximum: 300}
  validates :user_id, presence: true

end
