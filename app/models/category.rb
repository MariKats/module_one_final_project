require_relative './event_category.rb'

class Category < ActiveRecord::Base

  has_many :event_categories
  has_many :events, through: :event_categories

  def self.find_by(name)
    Category.where("name = ?", name)
  end

  def self.most_popular_category
    # most_popular = EventCategory.select(:category_id).order(EventCategory.arel_table[:category_id].count).reverse_order.group(EventCategory.arel_table[:category_id].count).limit(1)
    @popular = Category.joins(:events).group("categories.id").order("count(categories.id) DESC").first
  end

end

# most_popular =
# EventCategory.find_by_sql(
#   "SELECT category_id FROM event_categories
#   GROUP BY count(category_id)
#   ORDER BY count(category_id) DESC
#   LIMIT 1")
# Category.where(category.id = most_popular)
