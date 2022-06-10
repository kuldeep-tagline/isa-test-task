# frozen_string_literal: true

user = User.find_or_initialize_by(email: 'admin@test.com')
user.update(password: 'password')
ApiTokens::Create.new(user).call
