require 'devise/orm/active_record'
require 'models/user'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3',
                                        database: ':memory:')
# Dont output the ActiveRecord Migration logging during tests.
ActiveRecord::Migration.verbose = false

# Unremark me if you need to see SQL Query logs during testing (for debugging purposes)
# ActiveRecord::Base.logger = Logger.new(STDOUT) if defined?(ActiveRecord::Base)



def migration_folder name
  migrations_path = File.dirname(__FILE__)
  name ? File.join("#{migrations_path}" "#{name}") : "#{migrations_path}/migrations" # adding /migrations here is safer
end

def migrate name = nil
  mig_folder = migration_folder(name)

  puts "Migrating folder:" << mig_folder

  ActiveRecord::Migrator.migrate mig_folder
end