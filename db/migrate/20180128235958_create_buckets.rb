class CreateBuckets < ActiveRecord::Migration[5.1]
  def change
    create_table :buckets do |t|
      t.string :title
      t.text :description
      t.datetime :started_on
      t.datetime :complete_by
      t.string :user_id

      t.timestamps
    end
  end
end
