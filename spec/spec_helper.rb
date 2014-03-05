require 'active_record'
require 'versioned_record'

dbconfig = YAML::load_file(File.join(__dir__, 'database.yml'))
ActiveRecord::Base.establish_connection(dbconfig['postgresql'])

ActiveRecord::Schema.define :version => 0 do

  create_table :versioned_products, versioned: true, force: true do |t|
    t.string :name
  end
end

Dir[("./spec/support/**/*.rb")].each {|f| require f}

# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
end
