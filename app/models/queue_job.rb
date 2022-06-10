# frozen_string_literal: true

class QueueJob < ApplicationRecord
  before_create :set_run_at

  enum priority: %i[critical high low]
  enum status: %i[waiting in_progress done]
  enum job_type: %i[return_date_job create_movie_title_job]

  def set_run_at
    self.run_at = Time.now if run_at.nil?
  end

  def perform
    type.classify.perform_now
    update(status: :done)
  end
end
