class BucketSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :user_id, :started_on, :complete_by, :created_at, :updated_at

  has_many :tasks
end
