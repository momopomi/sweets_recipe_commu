class Recipe < ApplicationRecord
  belongs_to :customer
  belongs_to :genre
  has_many :comments, dependent: :destroy
  has_one_attached :image

  validates :recipe_name, presence: true
  validates :required_time, presence: true, numericality: { only_integer: true, greater_than: 0}
  validates :ingredient, presence: true
  validates :process, presence: true
end
