class Task < ApplicationRecord
  belongs_to :project
  validates :name, presence: true,
                   length: { minimum: 6, maximum: 35},
                   uniqueness: { case_sensitive: false }
end
