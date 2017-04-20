require_relative "../config/environment.rb"
require_relative "./meetup_api_test.rb"

def welcome
  puts "Welcome!".colorize(:blue)
end

def zipcode
  puts "Please enter your zipcode.".colorize(:blue)
  zip = gets.chomp
  if zip.length != 5
    puts "Your zipcode is not valid. Please enter a valid zipcode.".colorize(:blue)
    zip = gets.chomp
  end
  zip.to_i
end

def category
  puts "Please select the category that you are interested in, from list below: \n 1 = Arts & Culture \n 2 = Career & Business \n 3 = Dancing \n 4 = Fashion & Beauty \n 5 = Fitness \n 6 = Food & Drink \n 7 = Games \n 8 = Hobbies & Crafts \n 9 = Movies & Film \n 10 = Music \n 11 = Outdoors & Adventure \n 12 = Photography \n 13 = Singles \n 14 = Sports & Recreation \n 15 = Technology".colorize(:blue)
  category_number = gets.chomp
  if category_number.to_i > 15
    puts "Please enter a valid category number".colorize(:red)
    category_number = gets.chomp
  elsif category_number == "1"
    cat_name = 1
  elsif category_number == "2"
    cat_name = 2
  elsif category_number == "3"
    cat_name = 5
  elsif category_number == "4"
    cat_name = 8
  elsif category_number == "5"
    cat_name = 9
  elsif category_number == "6"
    cat_name = 10
  elsif category_number == "7"
    cat_name = 11
  elsif category_number == "8"
    cat_name = 15
  elsif category_number == "9"
    cat_name = 20
  elsif category_number == "10"
    cat_name = 21
  elsif category_number == "11"
    cat_name = 23
  elsif category_number == "12"
    cat_name = 27
  elsif category_number == "13"
    cat_name = 30
  elsif category_number == "14"
    cat_name = 32
  elsif category_number == "15"
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
  elsif cat_name == 8
    category_full_name = "Fashion & Beauty"
  elsif cat_name == 9
    category_full_name = "Fitness"
  elsif cat_name == 10
    category_full_name = "Food & Drink"
  elsif cat_name == 11
    category_full_name = "Games"
  elsif cat_name == 15
    category_full_name = "Hobbies & Crafts"
  elsif cat_name == 20
    category_full_name = "Movies & Film"
  elsif cat_name == 21
    category_full_name = "Music"
  elsif cat_name == 23
    category_full_name = "Outdoors & Adventure"
  elsif cat_name == 27
    category_full_name = "Photography"
  elsif cat_name == 30
    category_full_name = "Singles"
  elsif cat_name == 34
    category_full_name = "Technology"
  end
  category_full_name
end

def date_to_epoch(date)
  array = date.split("/")
  month = array[0].to_i
  day = array[1].to_i
  year = array[2].to_i
  converted_date = DateTime.new(year,month,day).strftime('%Q')
  converted_date.to_i
end

def epoch_to_date(epoch)
  sec = (epoch.to_f / 1000)
  Time.at(sec)
end

def date_to_formatted_date(date)
  array = date.split("/")
  month = array[0].to_i
  day = array[1].to_i
  year = array[2].to_i
  converted_date = DateTime.new(year,month,day).strftime('%m/%d/%Y %T')
end

def start_time
  puts "Please enter a start date (mm/dd/yyyy) for your search:"
  imputed_date = gets.chomp
  start_t = date_to_formatted_date(imputed_date)
  if start_t < DateTime.now.beginning_of_day.strftime('%m/%d/%Y %T')
    puts "You can't go back in time, can you? Please enter a current or future date!"
    start_time
  else
    start_t = date_to_epoch(imputed_date)
  end
  start_t
end

def end_time
  puts "Please enter an end date (mm/dd/yyyy) for your search:"
  imputed_date = gets.chomp
  end_time = date_to_epoch(imputed_date)
  end_time
end

def invalid_dates(start, endt)
  if endt < start
    puts "Your end date is before your start date. Please enter a valid end date"
    return true
  else
    return false
  end
end


def pick_favorite
  puts "Do you want to bookmark any of the above events? (y/n)"
  answer = gets.chomp
  if answer.downcase == "y"
    puts "Enter the event number of the event you want to bookmark."
    event_picked = gets.chomp.to_i
  elsif answer.downcase == "n"
    event_picked = nil
  end
end

def exit_method
  puts "Thank you for your time. See you soon!"
end

def save_favorite(user_favorite, events_output, category_name)
  event = events_output["results"][user_favorite-1]
  time = epoch_to_date(event["time"])
  new_event = Event.create(name: event["name"], host: event["group"]["name"], url: event["event_url"], date: time)
  new_category = Category.create(name: category_name)
  new_event.categories << new_category
  display_favorite(new_event)
end

def display_favorite(event_saved)
  puts "You have bookmarked: \n Event Name: #{event_saved.name} \n Event Host: #{event_saved.host} \n Event Date: #{event_saved.date} \n Event Link: #{event_saved.url} \n If you want information on the event, enter 1"
  answer = gets.chomp
  if answer == "1"
    Launchy.open "#{event_saved.url}"
  end
end

def run
  welcome
  zip = zipcode
  cat_name = category
  check_if_false = true
  while check_if_false
    start = start_time
    end_t = end_time
    check_if_false = invalid_dates(start, end_t)
  end
  events = GetEvents.new
  events_output = events.get_events_by_zipcode_category_and_time(zip, cat_name, start, end_t)
  category_name = meetup_categories(cat_name)
  user_favorite = pick_favorite
  if user_favorite == nil
    exit_method
  else
    save_favorite(user_favorite, events_output, category_name)
  end
end

run
