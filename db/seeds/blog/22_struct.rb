#!/bin/env ruby
# encoding: utf-8

@struct_1 = Blog::Screencast.create :user => @primal_user.blog_user,
  :title => "Struct",
  :summary => "",
  :embed => "",
  :snippet => Blog::Snippet.create(:erb => %q{
    <p>
      # berlimioz about struct : (link)Ror french cast
    </p>
    
    <p>
      Main
    </p>

    <%= coderay do %>
datas = [
  [1775, "American revolution", "North America"],
  [1989, "Tearing Down of Berlin Wall", "Germany"],
  [1914, "Worl war one", "Europe"],
  [1440, "Gutenberg's Printing Press", "Unknown"]
]

report = Report.new("World important events", datas)
report.print(1900, 2000)
    <% end %>
    
    <p>
      Base
    </p>
    
    <%= coderay do %>
class Report
  attr_accessor :title, :events

  def initialize title, datas
    @title = title
    @events = datas
  end

  def print start_date, end_date
    events_within_date_range = events.inject([]) do |events_within_date_range, event|
      if event[0] > start_date and event[0] < end_date
        events_within_date_range << event
      end
      events_within_date_range
    end

    events_within_date_range.sort_by{ |event| event[0] }.each do |event|
      puts %Q{
        +--------
        I Title: #{ event[1] }
        I Location: #{ event[2] }
        I Date: #{ event[0] }
        +--------
      }
    end
  end
end
    <% end %>
    
    <p>
      Refactoring
    </p>
    
    <%= coderay do %>
class Report
  def initialize title, datas
    @title = title
    @events = eventify datas
  end
  
  Event = Struct.new :date, :title, :location
  
  def eventify datas
    datas.map do |data|
      Event.new data[0], data[1], data[2]
    end
  end
end
    <% end %>
  }),
  :pool => :htcpcp,
  :published => false,
  :published_at => "".to_datetime,
  :tag => :struct

@struct_2 = Blog::Screencast.create :user => @primal_user.blog_user,
  :summary => "",
  :embed => "",
  :snippet => Blog::Snippet.create(:erb => %q{
    <p>
      Refactoring
    </p>
    
    <%= coderay do %>
class Report
  def events_within_date_range start_date, end_date
    events.inject([]) do |events_within_date_range, event|
      if event.within_date_range? start_date, end_date
        events_within_date_range << event
      end
      events_within_date_range
    end
  end
  
  def print start_date, end_date
    events_within_date_range(start_date, end_date).sort_by{ |event| event.date }.each do |event|
      event.print
    end
  end
  
  Event = Struct.new :date, :title, :location do
    def within_date_range? start_date, end_date
      date > start_date and date < end_date
    end
    
    def print
      puts %Q{
        +--------
        I Title: #{ title }
        I Location: #{ location }
        I Date: #{ date }
        +--------
      }
    end
  end
end
    <% end %>
  }),
  :pool => :htcpcp,
  :published => false,
  :published_at => "".to_datetime,
  :following => @struct_1

@struct_3 = Blog::Screencast.create :user => @primal_user.blog_user,
  :summary => "",
  :embed => "",
  :snippet => Blog::Snippet.create(:erb => %q{
    <p>
      Refactoring
    </p>
    
    <%= coderay do %>
class DateRange < Struct.new(:start_date, :end_date)
  def include? date
    (start_date..end_date).cover? date
  end
end
    <% end %>
    
    <%= coderay do %>
class Report
  def events_within_date_range date_range
    events.inject([]) do |events_within_date_range, event|
      if event.within_date_range? date_range
        events_within_date_range << event
      end
      events_within_date_range
    end
  end
  
  def print date_range
    events_within_date_range(date_range).sort_by{ |event| event.date }.each do |event|
      event.print
    end
  end
  
  Event = Struct.new :date, :title, :location do
    def within_date_range? date_range
      date_range.include? date
    end
  end
end
    <% end %>
  }),
  :pool => :htcpcp,
  :published => false,
  :published_at => "".to_datetime,
  :following => @struct_2
    
