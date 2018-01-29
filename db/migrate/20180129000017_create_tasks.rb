class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :status, default: "Unscheduled"
      t.text :description
      t.datetime :started_on
      t.datetime :complete_by
      t.references :bucket, foreign_key: true

      t.timestamps
    end
  end
end
