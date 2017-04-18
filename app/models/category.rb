require_relative './event_category.rb'

class Category
  attr_reader :name

  ALL = []

  def initialize(name)
    @name = name
    ALL << self
  end

  def self.all
    ALL
  end

  def events
    whatever = Event_category.all.select {|ev| ev.category == self}
    whatever.collect {|ev| ev.event}
  end
end
