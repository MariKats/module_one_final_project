require_relative "../config/environment.rb"
require_relative "./meetup_api_test.rb"

def welcome
  puts "Welcome!"
end

def zipcode
  puts "Please enter your zipcode."
  zip = gets.chomp

  # This doesn't work.
  # if zip != Integer ||
  #   puts "Please enter a valid zipcode."
  #   zip = gets.chomp
  # end
  zip.to_i
end

  def category
    puts "Please select the category that you are interested in, from list below: \n 1 = Arts & Culture \n 2 = Career & Business \n 3 = Dancing \n 4 = Fashion & Beauty \n 5 = Fitness \n 6 = Food & Drink \n 7 = Games \n 8 = Hobbies & Crafts \n 9 = Movies & Film \n 10 = Music \n 11 = Outdoors & Adventure \n 12 = Photography \n 13 = Singles \n 14 = Sports & Recreation \n 15 = Technology"
    category_number = gets.chomp
    if category_number == "1"
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

  def time_converter(date)
    array = date.split("/")
    month = array[0].to_i
    day = array[1].to_i
    year = array[2].to_i
    converted_date = DateTime.new(year,month,day).strftime('%Q')
  end

  def start_time
    puts "Please enter a start date (mm/dd/yyyy) for your search:"
    imputed_date = gets.chomp
    start_time = time_converter(imputed_date)

    # if start_time.to_i < DateTime.now.strftime('%Q')
    #   puts "You can't go back in time, can you? Please enter a current or future date!"
    #   imputed_date = gets.chomp
    #   start_time = time_converter(imputed_date).to_i
    # end
    start_time
  end

  def end_time
    puts "Please enter an end date (mm/dd/yyyy) for your search:"
    imputed_date = gets.chomp
    end_time = time_converter(imputed_date)
    end_time
  end


  def pick_favorite
    puts "Do you want to bookmark any of the above events? (y/n)"
    answer = gets.chomp
    if answer.downcase == "y"
    puts "Enter the event number of the event you want to bookmark."
    gets.chomp.to_i
  elsif no ....
  # do you want to pick other (y/n))
  # if yes category method
  #   if no exit method
  #   end

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
