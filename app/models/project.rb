# frozen_string_literal: true

class Project < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy
  validates :name, presence: true,
                   length: { minimum: 6, maximum: 35 },
                   uniqueness: { case_sensitive: false }
end
