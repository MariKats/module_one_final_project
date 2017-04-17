require_relative "./connection_adapter.rb"

DBRegistry ||= OpenStruct.new(test: ConnectionAdapter.new("db/meetup-test.db"),
  development: ConnectionAdapter.new("db/meetup-development.db"),
  production: ConnectionAdapter.new("db/meetup-production.db")
  )
