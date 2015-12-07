require 'sequel'
require 'sqlite3'

environments = ["test","development"]

environments.each do |env|
  Sequel.sqlite("db/user_password_#{env}.sqlite3").create_table(:user_password) do
    primary_key :id
    String :name
    String :password
  end
  puts "Migrated #{env} username password environment."
end
