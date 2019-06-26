# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(User, type: :model) do
  # Association test
  # ensure User model has a 1:m relationship with the Project model
  it { should have_many(:projects).dependent(:destroy) }
  # Validation tests
  # ensure columns email is present before saving
  it { should validate_presence_of(:email) }
end
