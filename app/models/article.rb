class Article < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: {minimum: 5, maximum: 18}
  validates :description, presence: true, length: {minimum: 10, maximum: 500}
end
