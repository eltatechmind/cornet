# frozen_string_literal: true

class TaskSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :plevel, :deadline, :done
  belongs_to :project
  has_many :comments
end
