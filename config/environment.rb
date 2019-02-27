require 'bundler'
Bundler.require

require_relative '../lib/student'

#this is possible because of the sqlite3 gem
DB = {:conn => SQLite3::Database.new("db/students.db")}
