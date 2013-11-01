#!/bin/env ruby
# encoding: utf-8

Blog::Screencast.create :user => @primal_user.blog_user,
  :title => "Opérateurs \"||\", \"or\", \"&&\" et \"and\"",
  :summary => "Quel est la différence entre l'opérateur \"||\" et l'opérateur \"or\" ? C'est ce qu'on va voir !",
  :embed => "bshV5tqzIwE",
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
  :tag => :or_and

Blog::Screencast.create :user => @primal_user.blog_user,
  :title => "Block, Proc et lambda",
  :summary => "Blocks, Procs et lambda en screencast, c'est ici que ça se passe !",
  :embed => "8Slu1_5xUYA",
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
  :tag => :blocks
    
Blog::Screencast.create :user => @primal_user.blog_user,
  :title => "Refactoring",
  :summary => "Le refactoring c'est chouette, alors pour cette fois, on va faire plein de trucs chouette avec une classe Product et Report.",
  :embed => "s6iMBtzo3nE",
  :snippet => Blog::Snippet.create(:erb => %q{
    <p>
      Talk original par Ben Orenstein, Aloha Ruby Conf 2012 : <%= link_to "Refactoring from good to great", "http://emaxime.com/2012/eys-refactoring-from-good-to-great-and-live/", :class => :btn, :target => "_blank" %> 
    </p>
    
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
  :tag => :refactoring
      
Blog::Screencast.create :user => @primal_user.blog_user,
  :title => "Null Pattern",
  :summary => "Suite sur le refactoring, en suivant le design \"NullPattern\"",
  :embed => "Z74ANuUEs7g",
  :snippet => Blog::Snippet.create(:erb => %q{
    <p>
      Talk original par Ben Orenstein, Aloha Ruby Conf 2012 : <%= link_to "Refactoring from good to great", "http://emaxime.com/2012/eys-refactoring-from-good-to-great-and-live/", :class => :btn, :target => "_blank" %> 
    </p>
    
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
  :tag => :null_pattern
        
Blog::Screencast.create :user => @primal_user.blog_user,
  :title => "Method missing",
  :summary => "Le method_missing, c'est LA fonctionnalité de métaprogrammation qui m'a fait aimer ruby, on va voir comment ça marche.",
  :embed => "X1bmSh72JoA",
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
  :tag => :method_missing

  
Blog::Screencast.create :user => @primal_user.blog_user,
  :title => "Belongs_to :HABTM",
  :summary => "Transformer une relation habtm en has_many/belongs_to, pourquoi ? comment ?",
  :embed => "kI4sG-HA7ZY",
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
  :tag => :habtm
  
Blog::Screencast.create :user => @primal_user.blog_user,
  :title => "Algorithme génétique",
  :summary => "Premier test sur les algorithmes génétiques, où on va tenter de résoudre un problème dit du \"paradoxe du singe savant\".",
  :embed => "oSkGssrsw_U",
  :snippet => Blog::Snippet.create(:erb => %q{
    <p>
      Blog d'lkdjiin : <%= link_to "Les algorithmes génétiques démystifiés", "http://lkdjiin.github.io/blog/2013/08/28/les-algorithmes-genetiques-demystifies/", :class => :btn, :target => "_blank" %>
    </p>
    
    <%= coderay do %>
def make_chromosome
  value = []
  length = @search_value.size
  length.times { value << random_gene }
  [nil, value.join]
end

def random_gene
  @genes[rand(@genes.size)]
end

def make_population
  population = []
  @population_size.times { population << make_chromosome }
  population
end

def score_population
  evaluate_population
  normalize_population_score
end

def evaluate_population
  @population.map! {|person| [evaluate(person.last), person.last] }
end

def evaluate(phrase)
  score = 0
  phrase.split(//).each_with_index do |character, index|
    score += 1 if @search_value[index] == character
  end
  score
end

def normalize_population_score
  total = @population.inject(0) {|sum, person| sum + person.first }
  @population.map! {|person| [person.first.to_f / total * 100, person.last] }
end

def next_generation
  mating_pool = create_mating_pool
  pool_size = mating_pool.size
  @population = []
  @population_size.times do
    parent1 = mating_pool[rand(pool_size)]
    parent2 = mating_pool[rand(pool_size)]
    @population << crossover(parent1, parent2)
  end
end

def create_mating_pool
  mating_pool = []
  @population.each do |person|
    person.first.to_i.times { mating_pool << person }
  end
  mating_pool
end

def crossover(parent1, parent2)
  point = rand(1..@search_value.size)
  child = parent1.last[0...point] + parent2.last[point..-1]
  [nil, mutate(child)]
end

def mutate(phrase)
  @search_value.size.times do |index|
    phrase[index] = random_gene if rand < @mutation_rate
  end
  phrase
end

def solution_found
  found = false
  @population.each do |person|
    if person.last == @search_value
		found = true 
	end
  end
  found
end
    <% end %>

    <%= coderay do %>
@search_value = "Mon royaume pour un cheval"
@genes = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ "

@population_size = 100
@mutation_rate = 1.0 / 100
@population = make_population

@bests = []

1000.times do |generation|
  score_population

	if generation % 10 == 0
		@bests << @population.sort{ |x| -x.first }.first
	end

	if solution_found
		@bests << @population.sort_by{ |x| -x.first }.first
		break
	end

	next_generation
end


?> @bests.each_with_index do |person, i|
*>   p "#{ person.last } - Score #{ evaluate person.last } - Generation #{ i }"
*> end
    <% end %>
  },
  :published => true),
  :pool => :try_hard,
  :published => true,
  :tag => :genetic
  
Blog::Screencast.create :user => @primal_user.blog_user,
  :title => "Algoritme génétique (suite)",
  :summary => "On va améliorer la fonction de reproduction qui posait problème dans l'épisode précédent.",
  :embed => "JSh8e73E5OQ",
  :snippet => Blog::Snippet.create(:erb => %q{
    <p>
      Blog d'lkdjiin : <%= link_to "Les algorithmes génétiques démystifiés", "http://lkdjiin.github.io/blog/2013/08/28/les-algorithmes-genetiques-demystifies/", :class => :btn, :target => "_blank" %>
    </p>
    
    <%= coderay do %>
def make_chromosome
  value = []
  length = @search_value.size
  length.times { value << random_gene }
  [nil, value.join]
end

def random_gene
  @genes[rand(@genes.size)]
end

def make_population
  population = []
  @population_size.times { population << make_chromosome }
  population
end

def score_population
  evaluate_population
  normalize_population_score
end

def evaluate_population
  @population.map! {|person| [evaluate(person.last), person.last] }
end

def evaluate(phrase)
  score = 0
  phrase.split(//).each_with_index do |character, index|
    score += 1 if @search_value[index] == character
  end
  score
end

def normalize_population_score
  total = @population.inject(0) {|sum, person| sum + person.first }
  @population.map! {|person| [person.first.to_f / total * 100, person.last] }
end

def next_generation
  mating_pool = create_mating_pool
  pool_size = mating_pool.size
  @population = []
  @population_size.times do
    parent1 = mating_pool[rand(pool_size)]
    parent2 = mating_pool[rand(pool_size)]
    @population << crossover(parent1, parent2)
  end
end

def create_mating_pool
  mating_pool = []
  @population.each do |person|
    person.first.to_i.times { mating_pool << person }
  end
  mating_pool
end

def crossover(parent1, parent2)
  point = rand(1..@search_value.size)
  child = parent1.last[0...point] + parent2.last[point..-1]
  [nil, mutate(child)]
end

def mutate(phrase)
  @search_value.size.times do |index|
    phrase[index] = random_gene if rand < @mutation_rate
  end
  phrase
end

def solution_found
  found = false
  @population.each do |person|
    if person.last == @search_value
		found = true 
	end
  end
  found
end
    <% end %>

    <%= coderay do %>
@search_value = "Mon royaume pour un cheval"
@genes = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ "

@population_size = 100
@mutation_rate = 1.0 / 100
@population = make_population

@bests = []

1000.times do |generation|
  score_population

	if generation % 10 == 0
		@bests << @population.sort{ |x| -x.first }.first
	end

	if solution_found
		@bests << @population.sort_by{ |x| -x.first }.first
		break
	end

	next_generation
end


?> @bests.each_with_index do |person, i|
*>   p "#{ person.last } - Score #{ evaluate person.last } - Generation #{ i }"
*> end
    <% end %>
  },
  :published => true),
  :pool => :try_hard,
  :published => true,
  :tag => :genetic_suite

Blog::Screencast.create :user => @primal_user.blog_user,
  :title => "Hill Climbing",
  :summary => "Le hill climbing, c'est un algorithme génétique simplifié, sans population et sans reproductions. On va voir comment ça se passe",
  :embed => "uCIQy1r2l34",
  :snippet => Blog::Snippet.create(:erb => %q{
    <%= coderay do %>
def make_gene
	@available_genes.sample
end

def make_person genes = []
	if genes.blank?
		@search_value.size.times{ genes << make_gene }
	end

	{:genes => genes.clone, :muted => genes.clone}
end

def evaluate_person person
	score = 0
	person[:genes].zip(@search_value).each_with_index do |(gene, searched_gene), index|
		if gene == searched_gene
			score += 1
		end

		if rand < @mutation_rate
			person[:muted][index] = make_gene
		end
	end

	person[:score] = score
end

def mutate_person person
	make_person person[:muted]
end
    <% end %>

    <%= coderay do %>
@searched_image = ChunkyPNG::Image.from_file("app/assets/images/blog/experience/octopusnocolor.png")

@search_value = @searched_image.pixels
@available_genes = @searched_image.pixels.uniq

@population_size = 100
@mutation_rate = 1.0 / 1_000

@bests_of_populations = []

@person = make_person
10_000.times do |generation|
	evaluate_person @person

	mutation = mutate_person @person
	evaluate_person mutation

	if generation % 100 == 0
		@bests_of_populations << @person
		p "Generation #{generation} - score #{@person[:score]}/#{@search_value.size}"
	end

	if mutation[:score] > @person[:score]
		@person = make_person mutation[:genes]
	else
		@person = make_person @person[:genes]
	end

	break if @person[:score] == @search_value.size
end
    <% end %>

    <p>
      For the views
    </p>

    <%= coderay do %>
def asset_data_uri path
	asset = Rails.application.assets.find_asset path

  throw "Could not find asset '#{path}'" if asset.nil?
  
  base64 = Base64.encode64(asset.to_s).gsub(/\s+/, "")
  "data:#{asset.content_type};base64,#{Rack::Utils.escape(base64)}"
end

def genes_to_uri genes
	png = ChunkyPNG::Image.new(@searched_image.width, @searched_image.height, genes)
	png.save("app/assets/images/blog/experience/genetic_best.png")
	asset_data_uri("blog/experience/genetic_best.png")
end

?> @bests_of_populations.each do |person| %>
*>   helper.image_tag genes_to_uri(person[:genes])
?> end
    <% end %>
  },
  :published => true),
  :pool => :try_hard,
  :published => true,
  :tag => :hill_climbing
  