# frozen_string_literal: true

class ReturnDateJob < ApplicationJob
  def perform
    puts "ReturnDateJob :: current date is : #{DateTime.now}"
  end
end
