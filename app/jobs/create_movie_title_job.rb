# frozen_string_literal: true

class CreateMovieTitleJob < ApplicationJob
  def perform(movie)
    Movie.create(movie)
  end
end
