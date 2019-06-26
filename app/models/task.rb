class Task < ApplicationRecord
  belongs_to :project
  has_many :comments, dependent: :destroy
  validates :name, presence: true,
                   length: { minimum: 6, maximum: 35},
                   uniqueness: { case_sensitive: false }
end
