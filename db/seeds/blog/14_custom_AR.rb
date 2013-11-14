#!/bin/env ruby
# encoding: utf-8

@custom_AR_1 = Blog::Screencast.create :user => @primal_user.blog_user,
  :title => "Custom AR",
  :summary => "Avec rails, on peut perdre de vue certaines mécaniques de ruby. Cette série va nous permettre de renouer avec les vielles habitudes.",
  :embed => "",
  :snippet => Blog::Snippet.create(:erb => %q{
    <%= coderay do %>
class Book
  attr_accessor :author

  def initialize options = {}
    @title, @author = options.values_at :title, :author

    @author.add_book self
  end

  def to_s
    "livre : #{ @title }"
  end
end

class Author
  attr_accessor :books

  def initialize options = {}
    @name = options[:name]

    @books = Array.new
  end

  def add_book book
    @books << book
  end

  def to_s
    "auteur : #{ @name }"
  end
end


author = Author.new name: :jeanne

book_1 = Book.new title: "La petite Sirene", author: author
book_2 = Book.new title: "La belle et la bete", author: author
    <% end %>
  }),
  :pool => :htcpcp,
  :published => true,
  :published_at => "15-11-2013".to_datetime,
  :serie => :custom_ar

@custom_AR_2 = Blog::Screencast.create :user => @primal_user.blog_user,
  :summary => "Après avoir reproduit le comportement has_many/belongs_to, on s'occupe maintenant des méthodes 'all' et 'find_by_*'.",
  :embed => "",
  :snippet => Blog::Snippet.create(:erb => %q{
    <%= coderay do %>
class Author
  attr_accessor :id, :name, :books

  def initialize options = {}
    @name = options[:name]

    @id = @@id += 1

    @books = Array.new
    @@all << self
  end

  def add_book book
    @books << book
  end

  def to_s
    "auteur : #{ @name }"
  end


  @@all = Array.new
  @@id = 0

  class << self
    def all
      @@all
    end

    def first
      @@all.first
    end

    def find_by_id id
      all.select{ |author| author.id == id }
    end

    def find_by_name name
      all.select{ |author| author.name == name }
    end
  end
end


author_1 = Author.new name: :jeanne
author_2 = Author.new name: :serge

book_1 = Book.new title: "La petite Sirene", author: author_1
book_2 = Book.new title: "La belle et la bete", author: author_1
book_3 = Book.new title: "Les trois petits cochon", author: author_2

puts Author.find_by_name :serge
puts Author.find_by_name :jeanne
    <% end %>
  }),
  :pool => :htcpcp,
  :published => true,
  :published_at => "15-11-2013".to_datetime,
  :following => @custom_AR_1
  
@custom_AR_3 = Blog::Screencast.create :user => @primal_user.blog_user,
  :summary => "Épisode final où -HO MY GOD- on va utiliser un method_missing pour dynamiser un petit peu nos jeunes méthodes 'find_by_*'.",
  :embed => "",
  :snippet => Blog::Snippet.create(:erb => %q{
    <%= coderay do %>
class Book
  attr_accessor :author

  def initialize options = {}
    @title, @author = options.values_at :title, :author

    @author.add_book self
  end

  def to_s
    "livre : #{ @title }"
  end
end

class Author
  attr_accessor :id, :name, :books

  def initialize options = {}
    @name = options[:name]

    @id = @@id += 1

    @books = Array.new
    @@all << self
  end

  def add_book book
    @books << book
  end

  def to_s
    "auteur : #{ @name }"
  end


  @@all = Array.new
  @@id = 0

  class << self
    def all
      @@all
    end

    def first
      @@all.first
    end

    def find_by attribute, value
      all.select{ |author| author.send(attribute) == value }
    end

    def method_missing method_name, *args, &block
      case method_name
      when /^find_by_(.*)$/
        find_by $1, *args, &block
      else
        super
      end
    end
  end
end


author_1 = Author.new name: :jeanne
author_2 = Author.new name: :serge

book_1 = Book.new title: "La petite Sirene", author: author_1
book_2 = Book.new title: "La belle et la bete", author: author_1
book_3 = Book.new title: "Les trois petits cochon", author: author_2

puts Author.find_by_id 2
puts Author.find_by_id 1
puts Author.find_by_name :serge
puts Author.find_by_name :jeanne
    <% end %>
  }),
  :pool => :htcpcp,
  :published => true,
  :published_at => "15-11-2013".to_datetime,
  :following => @custom_AR_2
