# frozen_string_literal: true

class ReturnDateJob < ApplicationJob
  def perform
    p ":::::::::::current date is : #{DateTime.now}"
  end
end
