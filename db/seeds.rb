require_relative '../app/models/category.rb'
require_relative '../app/models/event.rb'
require_relative '../app/models/event_category.rb'

tech = Category.create(name: "tech")
arts = Category.create(name: "arts")
sports = Category.create(name: "sports")
business = Category.create(name: "business")
knitting = Category.create(name: "knitting")
event_1 = Event.create(name: "Tom's Talk", host: "Tom", location: "Turing", date: "04/19/2017")
event_2 = Event.create(name: "Gaby's Talk", host: "Gaby", location:"Turing", date: "04/20/2017")
event_3 = Event.create(name: "Leia's Talk", host: "Leia", location: "Turing", date: "04/21/2017")
event_4 = Event.create(name: "Mari's Talk", host: "Mari", location: "Kay", date: "04/25/2017")
event_5 = Event.create(name: "JJ's Talk", host: "JJ", location: "Kay", date: "04/23/2017")
event_6 = Event.create(name: "Gaby's Second Talk", host: "Gaby", location: "Kay", date: "05/01/2017")

# event_category1 = EventCategory.create(category_id: tech.id, event_id: event_1.id)
# event_category2 = EventCategory.create(category_id: arts.id, event_id: event_2.id)
# event_category3 = EventCategory.create(category_id: sports.id, event_id: event_3.id)
# event_category4 = EventCategory.create(category_id: tech.id, event_id: event_4.id)
# event_category5 = EventCategory.create(category_id: business.id, event_id: event_5.id)
# event_category6 = EventCategory.create(category_id: knitting.id, event_id: event_6.id)
# event_category7 = EventCategory.create(category_id: sports.id, event_id: event_6.id)


tech.events << event_1
arts.events << event_2
tech.events << event_2
sports.events << event_3
business.events << event_4
knitting.events << event_4
tech.events << event_5
sports.events << event_6
