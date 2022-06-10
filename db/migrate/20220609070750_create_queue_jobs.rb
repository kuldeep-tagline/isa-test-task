# frozen_string_literal: true

class CreateQueueJobs < ActiveRecord::Migration[7.0]
  def change
    create_table :queue_jobs do |t|
      t.integer :priority, default: 0, null: false
      t.integer :status, default: 0, null: false
      t.datetime :run_at
      t.integer :job_type
      t.jsonb :movie, default: {}

      t.timestamps
    end
  end
end
