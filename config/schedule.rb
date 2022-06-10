# frozen_string_literal: true

require "./#{File.dirname(__FILE__)}/environment.rb"
set :chronic_options, hours24: true
set :output, { error: 'log/cron_error_log.log', standard: 'log/cron_log.log' }

every 1.minutes do
  rake 'job:run', environment: Rails.env
end
