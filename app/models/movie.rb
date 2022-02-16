class Movie < ApplicationRecord
  validates :name, :year, presence: true

  belongs_to :category
end
