#!/bin/env ruby
# encoding: utf-8

Blog::Screencast.create :user => @primal_user.blog_user,
  :title => "Try Hard #1",
  :summary => "Quel est la différence entre l'opérateur \"||\" et l'opérateur \"or\" ? C'est ce qu'on va voir !",
  :embed => "<iframe width=\"840\" height=\"500\" src=\"//www.youtube.com/embed/bshV5tqzIwE?rel=0\" frameborder=\"0\" allowfullscreen></iframe>",
  :snippet => Blog::Snippet.create(:erb => %q{
    <%= coderay do %>
?> var = false || true
=> true

?> var
=> true

#####
?> var = false or true
=> true

?> var
=> false
    <% end %>
    
    <%= coderay do %>
?> var ||= value
?> var = value if var.nil?
    <% end %>
    
    <%= coderay do %>
?> var &&= value
?> var = value unless var.nil?
    <% end %>
    
  },
  :published => true),
  :pool => :try_hard,
  :published => true,
  :tag => :try_hard_1

Blog::Screencast.create :user => @primal_user.blog_user,
  :title => "Try Hard #2",
  :summary => "Blocks, Procs et lambda en screencast, c'est ici que ça se passe !",
  :embed => "<iframe width=\"840\" height=\"500\" src=\"//www.youtube.com/embed/8Slu1_5xUYA?rel=0\" frameborder=\"0\" allowfullscreen></iframe>",
  :snippet => Blog::Snippet.create(:erb => %q{
		<%= coderay do %>
def easy
	yield
end

#or
def easy &block
  block.call
end

?> easy{ "I'm in a block !" }
=> "I'm in a block !"

#or
?> easy do
  "I'm in a block !"
end
=> "I'm in a block !"
		<% end %>
		
		<%= coderay do %>
def optional
	if block_given?
		yield
	else
		"No block here :("
	end
end

?> optional{ "I'm in a block again ! :)" }
=> "I'm in a block again ! :)"

?> optional
=> "No block here :("
		<% end %>
		
		<%= coderay do %>
def with_params
	yield 18
end

?> with_params{ |i| "I'm over #{ i }" }
=> "I'm over 18"
    <% end %>
    
    <%= coderay do %>
def arity &block
  block.arity
end

?> arity{}
=> 0

?> arity{ |a| }
=> 1

?> arity{ |a, b| }
=> 2

?> arity{ |*a| }
=> -1

?> arity{ |a, b, *c| }
=> -3
    <% end %>
    
    <%= coderay do %>
class Hash
	def compact &block
	  block ||= Proc.new{ |_, value| value.nil? }

		each do |key, value|
      delete key if block.call key, value
    end
	end
end

?> {:a => 100, :b => 200, :c => nil}.compact
=> {:a=>100, :b=>200}

?> {:a => 100, :b => 200, :c => nil}.compact{ |_, value| value.to_i > 150 }
=> {:a=>100, :c=>nil}

?> {:a => 100, :b => 200, "c" => nil}.compact{ |key, _| key.is_a? String }
=> {:a=>100, :b=>200}
		<% end %>
  },
  :published => true),
  :pool => :try_hard,
  :published => true,
  :tag => :try_hard_2
    
Blog::Screencast.create :user => @primal_user.blog_user,
  :title => "Try Hard #3",
  :summary => "Le refactoring c'est chouette, alors pour cette fois, on va faire plein de trucs chouette avec une classe Product et Report.",
  :embed => "<iframe width=\"840\" height=\"500\" src=\"//www.youtube.com/embed/s6iMBtzo3nE?rel=0\" frameborder=\"0\" allowfullscreen></iframe>",
  :snippet => Blog::Snippet.create(:erb => %q{
    <p>
      Main
    </p>
    
    <%= coderay do %>
load 'date.rb'

class Order
  attr_accessor :amount, :placed_at
  
  def initialize amount, placed_at
    @amount, @placed_at = amount, placed_at
  end
end

orders = [
  Order.new(50, Date.new(2013, 03, 14)),
  Order.new(75, Date.new(2013, 02, 12)),
  Order.new(25, Date.new(2013, 01, 03)),
  Order.new(150, Date.new(2012, 12, 15)),
  Order.new(100, Date.new(2012, 12, 24))
]

report_2012 = OrderReports.new orders, Date.new(2012, 01, 01), Date.new(2012, 12, 31)
report_2013 = OrderReports.new orders, Date.new(2013, 01, 01), Date.new(2013, 12, 31)

# After refactoring
# report_2012 = OrderReports.new orders, DateRange.new(Date.new(2012, 01, 01), Date.new(2012, 12, 31))
# report_2013 = OrderReports.new orders, DateRange.new(Date.new(2013, 01, 01), Date.new(2013, 12, 31))
		<% end %>
		
		<p>
		  Before Refactoring
		</p>
		
		<%= coderay do %>
class OrderReports
  def initialize orders, start_date, end_date
    @orders, @start_date, @end_date = orders, start_date, end_date
  end

  def total_sales_within_date_range
    orders_within_range =
      @orders.select do |order|
        order.placed_at >= @start_date &&
        order.placed_at <= @end_date
      end

    orders_within_range.
      map(&:amount).inject(0){ |sum, amount| amount + sum }
  end
end
    <% end %>
    
    <p>
		  After Refactoring
		</p>
		
		<%= coderay do %>
class DateRange < Struct.new(:start_date, :end_date)
  def include? date
    (start_date..end_date).cover?(date)
  end
end


class OrderReports
  def initialize orders, date_range
    @orders, @date_range = orders, date_range
  end

  def total_sales_within_date_range
    total_sales(orders_within_range)
  end

  private
  def total_sales orders
    orders.map(&:amount).inject(0){ |sum, amount| amount + sum }
  end

  def orders_within_range
    @orders.select do |order|
      order.placed_between?(@date_range)
    end
  end
end

class Order
  def placed_between? date_range
    date_range.include?(placed_at)
  end
end
    <% end %>
  },
  :published => true),
  :pool => :try_hard,
  :published => true,
  :tag => :try_hard_3
      
Blog::Screencast.create :user => @primal_user.blog_user,
  :title => "Try Hard #4",
  :summary => "Suite sur le refactoring, en suivant le design \"NullPattern\"",
  :embed => "<iframe width=\"840\" height=\"500\" src=\"//www.youtube.com/embed/Z74ANuUEs7g?rel=0\" frameborder=\"0\" allowfullscreen></iframe>",
  :snippet => Blog::Snippet.create(:erb => %q{
    <p>
      Main
    </p>
    
    <%= coderay do %>
class Contact < Struct.new(:name, :phone)
  def deleiver_personalized_email email_body
    p "email this : #{ email_body }"
  end
end

j1 = JobSite.new "Paris", Contact.new("Guillaume", "06.45.48.53.45")
j2 = JobSite.new "Toulouse", nil

print "Job site at #{ j1.location } \n Contact : #{ j1.contact_name } - #{ j1.contact_phone }"
print "\n\n"
print "Job site at #{ j2.location } \n Contact : #{ j2.contact_name } - #{ j2.contact_phone }"
print "\n\n"
    <% end %>
    
    <p>
		  Before Refactoring
		</p>
		
    <%= coderay do %>
class JobSite
  attr_accessor :location

  def initialize location, contact
    @location, @contact = location, contact
  end

  def contact_name
    if @contact
      @contact.name
    else
      'no name'
    end
  end

  def contact_phone
    if @contact
      @contact.phone
    else
      'no phone'
    end
  end

  def email_contact email_body
    if @contact
      @contact.deleiver_personalized_email(email_body)
    end
  end
end
    <% end %>  
    
    <p>
		  After Refactoring
		</p>
		
    <%= coderay do %>
class NullContact
  def name
    'no_name'
  end

  def phone
    'no_phone'
  end

  def deleiver_personalized_email email_body
  end
end

class JobSite
  attr_accessor :location

  def initialize location, contact
    @location = location
    @contact = contact || NullContact.new
  end

  def contact_name
    @contact.name
  end

  def contact_phone
    @contact.phone
  end

  def email_contact email_body
    @contact.deleiver_personalized_email(email_body)
  end
end
    <% end %>
  },
  :published => true),
  :pool => :try_hard,
  :published => true,
  :tag => :try_hard_4
        
Blog::Screencast.create :user => @primal_user.blog_user,
  :title => "Try Hard #5",
  :summary => "Le method_missing, c'est LA fonctionnalité de métaprogrammation qui m'a fait aimer ruby, on va voir comment ça marche.",
  :embed => "<iframe width=\"840\" height=\"500\" src=\"//www.youtube.com/embed/X1bmSh72JoA?rel=0\" frameborder=\"0\" allowfullscreen></iframe>",
  :snippet => Blog::Snippet.create(:erb => %q{
    <%= coderay do %>
class User
  @@all = Array.new
  
  def initialize options = {}
    @name, @city, @job = options.values_at :name, :city, :job
    @@all << self
  end
  
  def self.find_by attr, value
    @@all.select{ |user| user.instance_variable_get("@#{ attr }") == value }
  end
  
  def self.method_missing method_name, *args, &block
    case method_name
    when /^find_by_(.*)$/
      find_by $1, *args
    else
      super
    end
  end
  
  def self.respond_to? method_name
    case method_name
    when /^find_by_(.*)$/
      true
    else
      super
    end
  end
end

thomas = User.new name: :thomas, city: :toulouse, job: :web
gerome = User.new name: :gerome, city: :toulouse, job: :sport
jane = User.new name: :jane, city: :paris, job: :comedienne

p User.find_by_name :thomas
    <% end %>
    
    <%= coderay do %>
class Dynamic
  def self.method_missing method_name, *args, &block
    case method_name
    when /^(.*)=$/
      instance_variable_set "@#{ $1 }", args.first
    else
      instance_variable_get "@#{ method_name }"
    end
  end
end

?> dynamic = Dynamic.new
?> dynamic.title
=> nil

?> dynamic.title = "try hard"
?> dynamic.title
=> "try hard"
    <% end %>
  },
  :published => true),
  :pool => :try_hard,
  :published => true,
  :tag => :try_hard_5

  
Blog::Screencast.create :user => @primal_user.blog_user,
  :title => "Try Hard #6",
  :summary => "Transformer une relation habtm en has_many/belongs_to, pourquoi ? comment ?",
  :embed => "<iframe width=\"840\" height=\"500\" src=\"//www.youtube.com/embed/kI4sG-HA7ZY?rel=0\" frameborder=\"0\" allowfullscreen></iframe>",
  :snippet => Blog::Snippet.create(:erb => %q{
  <p>
    ArticleBlog Model
  </p>
  
  <%= coderay do %>
before_create :make_a_child
def make_a_child
  if ArticlesBlog.where(article_id: article).present?
    self.article = Article.create article.sync_attributes.merge parent: article
  end
  true
end
  <% end %>
  
  <p>
    Article Model
  </p>
  
  <%= coderay do %>
has_many :childs, :class_name => "Article", :foreign_key => "parent_article_id"
belongs_to :parent, :class_name => "Article", :foreign_key => "parent_article_id"

def parent?
  parent_article_id.blank?
end

SYNC_COLUMNS = column_names.reject{ |column| ["id", "parent_article_id"].include? column }
def sync_attributes
  SYNC_COLUMNS.inject({}) do |sync_attributes, column|
    sync_attributes[column] = send(column)
    sync_attributes
  end
end

attr_accessor :bypass_sync
before_update :sync_parent_or_childs, :unless => :bypass_sync
def sync_parent_or_childs
  if parent?
    childs.each do |child|
      child.update_attributes sync_attributes.merge bypass_sync: true
    end
  else
    parent.update_attributes sync_attributes.merge bypass_sync: true
  end
end
  <% end %>
  },
  :published => true),
  :pool => :try_hard,
  :published => true,
  :tag => :try_hard_6
  
Blog::Screencast.create :user => @primal_user.blog_user,
  :title => "Try Hard #7",
  :summary => "On va parler d'algorithmes génétiques",
  :embed => "<iframe width=\"840\" height=\"500\" src=\"//www.youtube.com/embed/oSkGssrsw_U?rel=0\" frameborder=\"0\" allowfullscreen></iframe>",
  :snippet => Blog::Snippet.create(:erb => %q{
  <p>
  Alors voilà jean-michel, un super screencast dites donc !
  </p>
  },
  :published => true),
  :pool => :try_hard,
  :published => true,
  :tag => :try_hard_7
  
Blog::Screencast.create :user => @primal_user.blog_user,
  :title => "Try Hard #7.5",
  :summary => "On va finir de parler des algorithmes génétiques",
  :embed => "<iframe width=\"840\" height=\"500\" src=\"//www.youtube.com/embed/JSh8e73E5OQ?rel=0\" frameborder=\"0\" allowfullscreen></iframe>",
  :snippet => Blog::Snippet.create(:erb => %q{
  <p>
  Alors voilà jean-michel, un super screencast dites donc !
  </p>
  },
  :published => true),
  :pool => :try_hard,
  :published => true,
  :tag => :try_hard_75
  