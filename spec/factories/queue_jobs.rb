# frozen_string_literal: true

FactoryBot.define do
  factory :queue_job do
    priority { 'high' }
    run_at { '2020-01-01' }

    trait :return_date_job do
      job_type { 'return_date_job' }
    end

    trait :movie_job do
      job_type { 'create_movie_title_job' }
    end
  end
end
