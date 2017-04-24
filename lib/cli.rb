require_relative "../config/environment.rb"
require_relative "./meetup_api_test.rb"

def welcome
  puts Rainbow("\nWelcome!\n\nThis is a search engine for meetup events. You can input your zipcode, select the category you are interested in and enter a timeframe for your search. You will get a list of events that you may want to go to! You will be able to bookmark the event you are interested in, view the event's webpage, and look back at previous events you have bookmarked.").blue
end

def zipcode
  puts Rainbow("\nPlease enter your zipcode:\n").blue
  zip = gets.chomp
  if zip.length != 5
    puts Rainbow("\nYour zipcode is not valid. Please enter a valid zipcode:\n").red
    zipcode
  end
  zip.to_i
end

def category_selections
   puts Rainbow("\nPlease select the category that you are interested in, from the list below:\n\n").blue + Rainbow(" 1  = Arts & Culture \n 2  = Career & Business \n 3  = Dancing \n 4  = Fashion & Beauty \n 5  = Fitness \n 6  = Food & Drink \n 7  = Games \n 8  = Hobbies & Crafts \n 9  = Movies & Film \n 10 = Music \n 11 = Outdoors & Adventure \n 12 = Photography \n 13 = Singles \n 14 = Sports & Recreation \n 15 = Technology \n").cyan
 end

 def category
   category_selections
   category_number = gets.chomp
   if category_number == "1"
     category_name = "Arts & Culture"
     category_id = 1
   elsif category_number == "2"
     category_name = "Careers & Business"
     category_id = 2
   elsif category_number == "3"
     category_name = "Dancing"
     category_id = 5
   elsif category_number == "4"
     category_name = "Fashion & Beauty"
     category_id = 8
   elsif category_number == "5"
     category_name = "Fitness"
     category_id = 9
   elsif category_number == "6"
     category_name = "Food & Drink"
     category_id = 10
   elsif category_number == "7"
     category_name = "Games"
     category_id = 11
   elsif category_number == "8"
     category_name = "Hobbies & Crafts"
     category_id = 15
   elsif category_number == "9"
     category_name = "Movies & Film"
     category_id = 20
   elsif category_number == "10"
     category_name = "Music"
     category_id = 21
   elsif category_number == "11"
     category_name = "Outdoors & Adventure"
     category_id = 23
   elsif category_number == "12"
     category_name = "Photography"
     category_id = 27
   elsif category_number == "13"
     category_name = "Singles"
     category_id = 30
   elsif category_number == "14"
     category_name = "Sports & Recreation"
     category_id = 32
   elsif category_number == "15"
     category_name = "Technology"
     category_id = 34
   else
     puts Rainbow("Please enter a valid category number.").red
     category
   end
   puts Rainbow("\nYou have selected #{category_name}. Was that the selection you wanted to make? ").blue + Rainbow("(y/n)\n").red
   {cat_name: category_name, cat_id: category_id}
 end

 def category_selected
   answer = gets.chomp
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
  puts Rainbow("\nPlease enter a start date for your search").blue + Rainbow(" (mm/dd/yyyy)").red + Rainbow(":\n").blue
  imputed_date = gets.chomp
  start_t = date_to_formatted_date(imputed_date)
  if start_t < DateTime.now.beginning_of_day.strftime('%m/%d/%Y %T')
    puts Rainbow("\nYou can't go back in time, can you? Please enter a current or future date!\n").red
    start_time
  else
    start_t = date_to_epoch(imputed_date)
  end
  start_t
end

def end_time
  puts Rainbow("\nPlease enter an end date for your search").blue + Rainbow(" (mm/dd/yyyy)").red + Rainbow(":\n").blue
  imputed_date = gets.chomp
  end_time = date_to_epoch(imputed_date)
  end_time
end

def invalid_dates(start, endt)
  if endt < start
    puts Rainbow("\nYour end date is before your start date. Please enter a valid end date.\n").red
    return true
  else
    return false
  end
end

def pick_favorite
  puts Rainbow("\nDo you want to bookmark any of the above events? ").blue + Rainbow("(y/n)\n").red
  answer = gets.chomp
  if answer.downcase == "y"
    puts Rainbow("\nPlease enter the event number of the event you want to bookmark.\n").blue
    event_picked = gets.chomp.to_i
  elsif answer.downcase == "n"
    event_picked = nil
  end
end

def exit_method
  puts Rainbow("\nThank you for your time. See you soon!\n").blue
end

def save_favorite(user_favorite, events_output, category_name)
  event = events_output["results"][user_favorite-1]
  time = epoch_to_date(event["time"])
  new_event = Event.create(name: event["name"], host: event["group"]["name"], url: event["event_url"], date: time)
  new_category = Category.find_or_create_by(name: category_name)
  # new_category = Category.create(name: category_name)
  new_event.categories << new_category
  display_favorite(new_event)
end

def display_favorite(event_saved)
  puts Rainbow("\nYou have bookmarked:\n\n").blue + Rainbow(" Name: #{event_saved.name} \n Host: #{event_saved.host} \n Date: #{event_saved.date} \n Link: #{event_saved.url}\n").cyan
  info
  answer = gets.chomp
  if answer == "1"
    Launchy.open "#{event_saved.url}"
  end
end

def info
puts Rainbow("If you want information on the event, ").blue + Rainbow("enter 1").red + Rainbow(", otherwise ").blue + Rainbow("enter 0\n").red
end

def ask_for_previous_events
  puts Rainbow("\nWould you like to see your previously bookmarked events? ").blue +  Rainbow("(y/n)\n").red
  answer = gets.chomp
  if answer.downcase == "y"
    show_events
  end
end

def show_events
  puts Rainbow("\nThese are your bookmarked events:\n").blue
  event_names = Event.all.collect do |event|
    event.name
  end
  event_names.join(',')
  event_names.each_with_index do |event, index|
    puts Rainbow(" #{index+1}. #{event}\n").cyan
  end
end

def show_favorite_category
  puts Rainbow("\nWould you like to see your most bookmarked category?").blue + Rainbow(" (y/n) \n").red
  answer = gets.chomp
  if answer.downcase == "y"
    Category.most_popular_category
    exit_method
  else
    exit_method
  end
end

def run
  welcome
  zip = zipcode

  selection = "n"
  while selection == "n"
    cat_hash = category
    cat_id = cat_hash[:cat_id]
    cat_name = cat_hash[:cat_name]
    selection = category_selected
  end

  check_if_false = true
  while check_if_false
    start = start_time
    end_t = end_time
    check_if_false = invalid_dates(start, end_t)
  end

  events = GetEvents.new
  events_output = events.get_events_by_zipcode_category_and_time(zip, cat_id, start, end_t)
  if events_output == false
    exit_method
  else
    user_favorite = pick_favorite
    if user_favorite == nil
      ask_for_previous_events
      show_favorite_category
    else
      save_favorite(user_favorite, events_output, cat_name)
      ask_for_previous_events
      show_favorite_category
    end

  end
end

run
