# require_relative "../app/models/event.rb"
# require_relative "../app/models/category.rb"
# require_relative "../app/models/event_category.rb"
require_relative "../config/environment.rb"
require_relative "./meetup_api_test.rb"
require 'pry'

def welcome
  puts "Welcome!"
end

def zipcode
  puts "Please enter your zipcode."
  zip = gets.chomp
  zip.to_i
end

  def category
    puts "Please select a category from below: \n 1 = Arts & Culture \n 2 = Career & Business \n 3 = Dancing \n 4 = Food & Drink \n 5 = Technology"
    category_number = gets.chomp
    if category_number == "1"
      cat_name = 1
    elsif category_number == "2"
      cat_name = 2
    elsif category_number == "3"
      cat_name = 5
    elsif category_number == "4"
      cat_name = 10
    elsif category_number == "5"
      cat_name = 34
    end
    cat_name
  end

  def meetup_categories(cat_name)
    if cat_name == 1
      category_full_name = "Arts & Culture"
    elsif cat_name == 2
      category_full_name = "Career & Business"
    elsif cat_name == 5
      category_full_name = "Dancing"
    elsif cat_name == 10
      category_full_name = "Food & Drink"
    elsif cat_name == 34
      category_full_name = "Technology"
    end
    category_full_name
  end

  def start_time
    puts "Please enter a start date (mm/dd/yyyy) for your search:"
    imputed_start_time = gets.chomp
    array = imputed_start_time.split("/")
    month = array[0].to_i
    day = array[1].to_i
    year = array[2].to_i
    # binding.pry

    start_time = DateTime.new(year,month,day).strftime('%Q')
    strt = start_time.to_i

    if start_time < DateTime.now.strftime('%Q')
      puts "You can't go back in time, can you? Please enter a current or future date!"
      imputed_start_time = gets.chomp
      array = imputed_start_time.split("/")
      month = array[0].to_i
      day = array[1].to_i
      year = array[2].to_i
      start_time = DateTime.new(year,month,day).strftime('%Q')
      strt = start_time.to_i
    end
    strt
  end

  def end_time
    puts "Please enter an end date (mm/dd/yyyy) for your search:"
    imputed_end_time = gets.chomp
    array = imputed_end_time.split("/")
    month = array[0].to_i
    day = array[1].to_i
    year = array[2].to_i
    end_time = DateTime.new(year,month,day).strftime('%Q')
    endt = end_time.to_i
    endt
  end

  def pick_favorite
    puts "Enter the event number of the event you want to go to."
    gets.chomp.to_i
  end

  def save_favorite(user_favorite, events_output, category_name)
    event = events_output["results"][user_favorite-1]
    new_event = Event.create(name: event["name"])
    new_category = Category.create(name: category_name)
    new_event.categories << new_category
  end

  def run
    welcome
    zip = zipcode
    cat_name = category
    start = start_time
    end_t = end_time
    events = GetEvents.new
    events_output = events.get_events_by_zipcode_category_and_time(zip, cat_name, start, end_t)
    category_name = meetup_categories(cat_name)
    user_favorite = pick_favorite
    save_favorite(user_favorite, events_output, category_name)
  end

  run
