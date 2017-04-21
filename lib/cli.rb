require_relative "../config/environment.rb"
require_relative "./meetup_api_test.rb"

def welcome
  puts Rainbow("\nWelcome!").blue
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
     cat_name = "Arts & Culture"
     cat_id = 1
   elsif category_number == "2"
     cat_name = "Careers & Business"
     cat_id = 2
   elsif category_number == "3"
     cat_name = "Dancing"
     cat_id = 5
   elsif category_number == "4"
     cat_name = "Fashion & Beauty"
     cat_id = 8
   elsif category_number == "5"
     cat_name = "Fitness"
     cat_id = 9
   elsif category_number == "6"
     cat_name = "Food & Drink"
     cat_id = 10
   elsif category_number == "7"
     cat_name = "Games"
     cat_id = 11
   elsif category_number == "8"
     cat_name = "Hobbies & Crafts"
     cat_id = 15
   elsif category_number == "9"
     cat_name = "Movies & Film"
     cat_id = 20
   elsif category_number == "10"
     cat_name = "Music"
     cat_id = 21
   elsif category_number == "11"
     cat_name = "Outdoors & Adventure"
     cat_id = 23
   elsif category_number == "12"
     cat_name = "Photography"
     cat_id = 27
   elsif category_number == "13"
     cat_name = "Singles"
     cat_id = 30
   elsif category_number == "14"
     cat_name = "Sports & Recreation"
     cat_id = 32
   elsif category_number == "15"
     cat_name = "Technology"
     cat_id = 34
   end
   puts Rainbow("\nYou have selected #{cat_name}. Was that the selection you wanted to make? ").blue + Rainbow("(y/n)\n").red
   cat_id
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
  new_category = Category.create(name: category_name)
  new_event.categories << new_category
  display_favorite(new_event)
end

# def popup(url)
#   puts Rainbow("\nIf you want information on the event, enter 1, otherwise, enter 0.\n").blue
#   answer = gets.chomp
#   if answer == "1"
#     Launchy.open "#{url}"
#   end
# end

# def display_favorite(event_saved)
#   puts Rainbow("\nYou have bookmarked: \n Name: ").black + Rainbow("#{event_saved.name} \n").cyan + Rainbow("\n Host: ").black + Rainbow("#{event_saved.host} \n").cyan + Rainbow("\n Date: ").black + Rainbow("#{event_saved.date} \n").cyan + Rainbow("\n Link: ").black + Rainbow("#{event_saved.event_url} \n").cyan
# end

def display_favorite(event_saved)
  puts Rainbow("\nYou have bookmarked:\n\n").blue + Rainbow(" Name: #{event_saved.name} \n Host: #{event_saved.host} \n Date: #{event_saved.date} \n Link: #{event_saved.url}\n").cyan


# puts Rainbow("\nYou have bookmarked: \n").black.underline
# puts Rainbow("Name: ").black + Rainbow("#{event_saved.name} \n").cyan
# puts Rainbow("\n Host: ").black + Rainbow("#{event_saved.host} \n").cyan + Rainbow("\n Date: ").black + Rainbow("#{event_saved.date} \n").cyan + Rainbow("\n Link: ").black + Rainbow("#{event_saved.event_url} \n").cyan

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
    exit_method
  else
    exit_method
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

def run
  welcome
  zip = zipcode

  selection = "n"
  while selection == "n"
    cat_name = category
    selection = category_selected
  end

  check_if_false = true
  while check_if_false
    start = start_time
    end_t = end_time
    check_if_false = invalid_dates(start, end_t)
  end

  events = GetEvents.new
  events_output = events.get_events_by_zipcode_category_and_time(zip, cat_name, start, end_t)
  if events_output == false
    exit_method
  else
    user_favorite = pick_favorite
    if user_favorite == nil
      ask_for_previous_events
    else
      save_favorite(user_favorite, events_output, cat_name)
      ask_for_previous_events
    end
  end
end

run
