require 'bundler'
Bundler.require

@db = ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')

require_all 'app'
