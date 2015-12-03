require 'sequel'
require 'sqlite3'

environments = ["test","development"]

environments.each do |env|
  database = Sequel.sqlite("db/robot_registry_#{env}.sqlite3").create_table(:robots) do
    primary_key :id
    Integer :avatar_id
    String :name
    String :city
    String :state
    String :operational
    String :weapons
    String :branch
  end
  puts "Migrated #{env} environment."
end
