require 'rails_helper'

RSpec.describe Bucket, type: :model do
  # Association test
  # ensure Bucket model has 1:m relationship with Task model
  it { should have_many(:tasks).dependent(:destroy) }

  # Validation tests
  # ensure columns title and description are present before saving
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
end
