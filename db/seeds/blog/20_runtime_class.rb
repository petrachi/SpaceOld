#!/bin/env ruby
# encoding: utf-8

@runtime_class_1 = Blog::Screencast.create :user => @primal_user.blog_user,
  :title => "Defining class at Runtime",
  :summary => "Ruby nous donne énormément d'outils de métaprogrammation, et nous allons découvrir ensemble comment définir des classes dynamiquement, au runtime !",
  :embed => "wQegMYKHxKg",
  :snippet => Blog::Snippet.create(:erb => %q{
    <p>
      Basic Usage
    </p>
    
    <%= coderay do %>
def create_user_class
  user_class = Class.new do
    def name
      "Thomas"
    end
  end

  Object.const_set "User", user_class
end

?> puts User.new.name
=> # uninitialized constant User (NameError)

?> create_user_class
?> puts User.new.name
=> "Thomas"
    <% end %>
    
    <p>
      With inheritance and namespacing
    </p>

    <%= coderay do %>
module Blog
  class MainUser
    def say_hello
      "Hello"
    end
  end
end

def create_user_class
  user_class = Class.new Blog::MainUser do
    def name
      "Thomas"
    end
  end

  Blog.const_set "User", user_class
end

?> puts Blog::User.new.name
=> # uninitialized constant Blog::User (NameError)

?> create_user_class
?> puts Blog::User.new.say_hello
=> "Hello"
        <% end %>
  }),
  :pool => :htcpcp,
  :published => true,
  :published_at => "09-12-2013".to_datetime,
  :tag => :class_at_runtime
  