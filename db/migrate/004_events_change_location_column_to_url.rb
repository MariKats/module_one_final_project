class EventsChangeLocationColumnToUrl < ActiveRecord::Migration

  def change
    rename_column :events, :location, :url
  end

end
