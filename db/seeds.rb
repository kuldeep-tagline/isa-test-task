# frozen_string_literal: true

user = User.find_or_create_by(emali: 'admin@test.com', password: 'password')
ApiTokens::Create.new(user).call
