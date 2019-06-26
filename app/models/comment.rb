class Comment < ApplicationRecord
  belongs_to :task
  validates :content, presence: true,
                   length: { minimum: 6, maximum: 35},
                   uniqueness: { case_sensitive: false }
end
