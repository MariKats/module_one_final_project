require_relative './event_category.rb'
require 'pry'

class Event
  attr_reader :name, :host, :location, :date

  ALL = []

  def initialize(name, host, location)
    @name = name
    @host = host
    @location = location
    @date = date
    ALL << self
  end

  def self.all
    ALL
  end

  def self.find_by_name(name)
    self.all.find {|event| event.name == name}
  end

  def self.find__all_by_host(host)
    event = self.all.find_all {|event| event.host == host}
    event.uniq
  end

  def self.find_all_by_location(location)
    event = self.all.find_all {|event| event.location == location}
    event.uniq
  end

  def create_event_category(category)
    Event_category.new(self, category)
  end

  def category
    whatever = Event_category.all.select {|ev| ev.event == self}
    whatever.collect {|ev| ev.category}
  end
end
# binding.pry
# "ohyea"
