# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'

def preview_a_new_message(new_message)
  
  #fill_in "Image", with: new_message.image
  fill_in "message_question", with: new_message.question
  fill_in "message_button1", with: new_message.button1
  fill_in "message_button2", with: new_message.button2
  fill_in "message_response1", with: new_message.response1
  fill_in "message_response2", with: new_message.response2
  click_on "Preview"
end


def update_draft_message
  fill_in "message_question", with: "Am I more bad ass than Gerard?" 
  fill_in "message_button1", with: "Yes"
  fill_in "message_button2", with: "No"
  fill_in "message_response1", with: "Suck it nerd... no you're not."
  fill_in "message_response2", with: "Better luck next time chump!"

end
# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"
end
