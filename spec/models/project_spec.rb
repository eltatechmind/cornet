# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(Project, type: :model) do
  # Association test
  # ensure a project record belongs to a single user record
  it { should belong_to(:user) }
  # Validation test
  # ensure column name is present before saving
  it { should validate_presence_of(:name) }
end
