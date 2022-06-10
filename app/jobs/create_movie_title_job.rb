# frozen_string_literal: true

class CreateMovieTitleJob < ApplicationJob
  def perform(movie)
    Movie.create(movie)
    p 'CreateMovieTitleJob :: Movie has beed created successfully!'
  end
end
