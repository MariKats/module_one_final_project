class Event_category

  attr_reader :event, :category
  ALL = []

  def self.all
    ALL
  end

  def initialize
    ALL << self
  end

end
