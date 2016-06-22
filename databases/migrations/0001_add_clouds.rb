require 'sequel'

Sequel.migration do
  change do
    create_table :clouds do
      primary_key :id
      String :type
      Date :spotted_at
    end
  end
end
