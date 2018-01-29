require 'rails_helper'

RSpec.describe Task, type: :model do
  # Association test
  # ensure a task belongs to one bucket
  it { should belong_to(:bucket) }
  
  # Validation test
  # ensure columns title and status are present before saving
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:status) }
end
