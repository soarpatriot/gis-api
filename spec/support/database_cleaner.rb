require "database_cleaner"

RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with :truncation
  end

  config.before(:each) do |x|
    DatabaseCleaner.start
  end

  config.after(:each) do |x|
    DatabaseCleaner.clean
  end

end
