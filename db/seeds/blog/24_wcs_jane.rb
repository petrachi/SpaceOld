#!/bin/env ruby
# encoding: utf-8

@wcs_1 = Blog::Screencast.create :user => @primal_user.blog_user,
  :title => "Prélude WCS:Jane",
  :summary => "Nouvelle émission : On part de zéro et va construire un site internet complet ! Et dans ce prélude, on fait un petit tour du langage ruby ! Youpi !",
  :embed => "pofjHEBRwgE",
  :snippet => Blog::Snippet.create(:erb => %q{
    <p>
      Exercice
    </p>

    <%= coderay do %>
# Create a library named "SpaceLibrary"
# A library contains Books
# A Book have a title and an Author
# An Author has a name

# Janet & Allan Ahlberg have written : 
# Each Peach Pear Plum
# The Jolly Postman or Other People’s Letters

# Raymond Briggs have written The Snowman
# John Burningham have written Would You Rather?
# And Eric Carle have written The Very Hungry Caterpillar

# The library should be able to show a list of all its books, ordered by title, or by author
    <% end %>
  }),
  :pool => :wcs_jane,
  :published => true,
  :published_at => "30-01-2014".to_datetime,
  :serie => :prelude_wcs_jane

@wcs_2 = Blog::Screencast.create :user => @primal_user.blog_user,
  :summary => "Définition du concept de classes et d'objets en ruby, plus un peu de syntaxe qui va bien.",
  :embed => "4MKmprtkT4I",
  :snippet => Blog::Snippet.create(:erb => %q{
    <p>
      Classes
    </p>
    
    <%= coderay do %>
class Library
  def initialize name
    @name = name
  end
end

class Book
  def initialize title
    @title = title
  end
end

class Author
  def initialize name
    @name = name
  end
end
    <% end %>
    
    <p>
      Main
    </p>
    
    <%= coderay do %>
space_library = Library.new("Space Library")
    <% end %>
  }),
  :pool => :wcs_jane,
  :published => true,
  :published_at => "30-01-2014".to_datetime,
  :following => @wcs_1

@wcs_3 = Blog::Screencast.create :user => @primal_user.blog_user,
  :summary => "On continue et on crée des synergies entre nos différentes classes.",
  :embed => "JYDYDTZK9r8",
  :snippet => Blog::Snippet.create(:erb => %q{
    <p>
      <%= coderay({inline: true}, "Book") %>, <%= coderay({inline: true}, "Author") %> & <%= coderay({inline: true}, "Library") %>
    </p>
  
    <%= coderay do %>
class Library
  attr_accessor :name, :books

  def initialize name
    @name = name
    @books = []
  end

  def add_book book
    @books << book
  end
end

class Book
  attr_accessor :title, :author, :library

  def initialize title, author, library
    @title = title
    @author = author
    @library = library

    author.add_book self
    library.add_book self
  end
end

class Author
  attr_accessor :name, :books

  def initialize name
    @name = name
    @books = []
  end

  def add_book book
    @books << book
  end
end
    <% end %>
    
    <p>
      Main
    </p>
    
    <%= coderay do %>
space_library = Library.new("Space Library")

author_ahlberg = Author.new "Janet & Allan Ahlberg"
book_peach = Book.new "Each Peach Pear Plum", author_ahlberg, space_library
book_postman = Book.new "The Jolly Postman or Other People's Letters", author_ahlberg, space_library
    <% end %>
  }),
  :pool => :wcs_jane,
  :published => true,
  :published_at => "30-01-2014".to_datetime,
  :following => @wcs_2
  
@wcs_4 = Blog::Screencast.create :user => @primal_user.blog_user,
  :summary => "On arrive sur la fin de l'exercice, et on réussit cette fois à afficher la liste des livres présents dans notre bibliothèque.",
  :embed => "q5xF5n4JZJU",
  :snippet => Blog::Snippet.create(:erb => %q{
    <p>
      Afficher la liste des <%= coderay({inline: true}, "Book") %>s
    </p>

    <%= coderay do %>
class Library
  def inspect
    @books.map do |book|
      book.inspect
    end
  end
end

class Book
  def inspect
    %Q{
      -- Book --
      Title : #{ @title }
      Author : #{ @author.name }
    }
  end
end
    <% end %>
    
    <p>
      Main
    </p>
    
    <%= coderay do %>
space_library = Library.new("Space Library")

Book.new "Each Peach Pear Plum", (author = Author.new "Janet & Allan Ahlberg"), space_library
Book.new "The Jolly Postman or Other People's Letters", author, space_library

Book.new "The Snowman", Author.new("Raymond Briggs"), space_library
Book.new "Would You Rather?", Author.new("John Burningham"), space_library
Book.new "The Very Hungry Caterpillar", Author.new("Eric Carle"), space_library
    <% end %>
  }),
  :pool => :wcs_jane,
  :published => true,
  :published_at => "30-01-2014".to_datetime,
  :following => @wcs_3
  
@wcs_5 = Blog::Screencast.create :user => @primal_user.blog_user,
  :summary => "On va plus loin pour permettre d'ordonner l'affichage des livres. Un peu d'ordre, ça fait du bien.",
  :embed => "_eNf53OwEoQ",
  :snippet => Blog::Snippet.create(:erb => %q{
    <p>
      La loi et l'ordre
    </p>

    <%= coderay do %>
class Library
  def books order = nil
    case order
    when "book_title"
      @books.sort_by do |book|
        book.title
      end
    when "author_name"
      @books.sort_by do |book|
        book.author.name
      end
    else
      @books
    end
  end
  
  def inspect order = nil
    books(order).map do |book|
      book.inspect
    end
  end
  
  def inspect_by_book_title
    inspect(:book_title)
  end

  def inspect_by_author_name
    inspect(:author_name)
  end
end
    <% end %>
    
    <p>
      Main
    </p>
    
    <%= coderay do %>
?> space_library.inspect_by_book_title
=> "-- Book --
Title : The Very Hungry Caterpillar
Author : Eric Carle


-- Book --
Title : The Jolly Postman or Other People's Letters
Author : Janet & Allan Ahlberg


-- Book --
Title : Each Peach Pear Plum
Author : Janet & Allan Ahlberg


-- Book --
Title : Would You Rather?
Author : John Burningham


-- Book --
Title : The Snowman
Author : Raymond Briggs"
    <% end %>
  }),
  :pool => :wcs_jane,
  :published => true,
  :published_at => "30-01-2014".to_datetime,
  :following => @wcs_4

@wcs_6 = Blog::Screencast.create :user => @primal_user.blog_user,
  :summary => "Dernière partie et fin de l'épisode, on donner un rapide aperçu des possibilités folles de ruby via le method_missing et le define_method ! Whoaw !",
  :embed => "0qgOMBJ8v14",
  :snippet => Blog::Snippet.create(:erb => %q{
    <p>
      Method missing
    </p>

    <%= coderay do %>
class Library
  def method_missing method_name, *args, &block
    case method_name
    when /^inspect_by_(.*)$/
      inspect($1)
    else
      super
    end
  end

  def respond_to? method_name, *args
    case method_name
    when /^inspect_by_(.*)$/
      true
    else
      super
    end
  end
end
    <% end %>
    
    <p>
      Define method
    </p>
    
    <%= coderay do %>
class Library
  ["book_title", "author_name"].each do |order|
    define_method "inspect_by_#{ order }" do
      inspect(order)
    end
  end
end
    <% end %>
  }),
  :pool => :wcs_jane,
  :published => true,
  :published_at => "30-01-2014".to_datetime,
  :following => @wcs_5
