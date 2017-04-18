require "/Users/marianna/Development/labs/MODULE ONE/project-module-one/module_one_final_project/app/models/category.rb"
require "/Users/marianna/Development/labs/MODULE ONE/project-module-one/module_one_final_project/app/models/event.rb"
require "/Users/marianna/Development/labs/MODULE ONE/project-module-one/module_one_final_project/app/models/event_category.rb"

Category.create(name: "tech")
Category.create(name: "arts")
Category.create(name: "sports")
Category.create(name: "business")
Category.create(name: "knitting")
Event.create(name: "Tom's Talk", host: "Tom", location: "Turing", date: "04/19/2017")
Event.create(name: "Gaby's Talk", host: "Gaby", location:"Turing", date: "04/20/2017")
Event.create(name: "Leia's Talk", host: "Leia", location: "Turing", date: "04/21/2017")
Event.create(name: "Mari's Talk", host: "Mari", location: "Kay", date: "04/25/2017")
Event.create(name: "JJ's Talk", host: "JJ", location: "Kay", date: "04/23/2017")
Event.create(name: "Gaby's Second Talk", host: "Gaby", location: "Kay", date: "05/01/2017")
