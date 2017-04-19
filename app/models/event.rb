# require_relative './event_category.rb'
require 'pry'

class Event < ActiveRecord::Base

  has_many :event_categories
  has_many :categories, through: :event_categories

  def self.find_by(host)
    Event.where("host = ?", host)
  end

  def self.find_by(name)
    Event.where("name = ?", name)
  end

  def self.find_by(location)
    Event.where("location = ?", location)
  end

  def self.find_by(date)
    Event.where("date = ?", date)
  end

end
