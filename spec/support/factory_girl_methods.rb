require "factory_girl"

Dir[G2.config.root_dir + "/spec/factories/**/*.rb"].each {|f| require f}

RSpec.configure do |c|
  c.include FactoryGirl::Syntax::Methods
end
