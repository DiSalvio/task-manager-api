class Task < ApplicationRecord
  belongs_to :bucket

  validates_presence_of :title, :status
end
