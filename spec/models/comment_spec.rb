# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(Comment, type: :model) do
  # Association test
  # ensure a comment record belongs to a single task record
  it { should belong_to(:task) }
  # Validation test
  # ensure column conent is present before saving
  it { should validate_presence_of(:content) }
end
