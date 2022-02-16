class Category < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }

  has_many :movies

  accepts_nested_attributes_for :movies, allow_destroy: true


end
