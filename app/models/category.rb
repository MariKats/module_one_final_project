# require_relative './event_category.rb'

class Category < ActiveRecord::Base

  has_many :event_categories
  has_many :events, through: :event_categories

  def self.find_by(name)
    Category.where("name = ?", name)
  end

  def self.most_popular_category
    result = ActiveRecord::Base.connection.execute("SELECT categories.name FROM categories
    JOIN event_categories ON categories.id = event_categories.category_id
    GROUP BY category_id ORDER BY (COUNT(event_categories.category_id)) DESC
    LIMIT 1")
    result_name = result.first["name"]
    puts Rainbow("\n#{result_name} is your most bookmarked event category!\n").blue
  end
end
