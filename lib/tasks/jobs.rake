# typed: strict
# frozen_string_literal: true

namespace :job do
  desc 'desc'
  task run: :environment do
    QueueJob.where('created_at >= ?', 1.minute.ago).or(QueueJob.where(status: :waiting)).order(:priority).each do |job|
      if job.run_at
        if (1.minute.ago..DateTime.now).cover?(job.run_at)
          job.perform
        elsif DateTime.now > job.run_at # run_at should be in past
          job.perform
        end
      else
        job.perform
      end
    end
  end
end
