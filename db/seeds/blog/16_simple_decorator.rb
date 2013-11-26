#!/bin/env ruby
# encoding: utf-8

@simple_decorator_1 = Blog::Screencast.create :user => @primal_user.blog_user,
  :title => "Simple Decorator",
  :summary => "Les decorators, c'est la solution pour faire du code de modèle orienté vues, et garder une architecture pas dégueulasse. On va voir comment implémenter ça, et sans gem !",
  :embed => "5p-qc-MQy90",
  :snippet => Blog::Snippet.create(:erb => %q{
    <p>
      Decorator
    </p>
    
    <%= coderay do %>
# app/decorators/base_decorator.rb
class BaseDecorator < SimpleDelegator
  def initialize base, view_context
    super(base)

    @view_context = view_context
  end

  def h
    @view_context
  end
end

# app/decorators/todo_decorator.rb
class TodoDecorator < BaseDecorator
  def completed
		if super
      h.content_tag :span, "Completed", style: "color: green;"
		else
			'-'
		end
  end
end
    <% end %>
    
    <p>
      Controller
    </p>
    
    <%= coderay do %>
# app/controllers/todo_controller.rb:show
@todo = TodoDecorator.new Todo.find(params[:id]), view_context
    <% end %>
    
    <p>
      Helper
    </p>
    
    <%= coderay do %>
# app/helpers/application_helper.rb
def decorate decorator, instance, &block
  capture do
    block.call decorator.new(instance, self)
  end
end
    <% end %>
    
    <p>
      View
    </p>
    
    <%= coderay lang: :erb do %>
<!-- app/views/todos/index.html.erb -->
<%%= decorate TodoDecorator, todo do |decorated_todo| %>
	<%%= decorated_todo.completed %>
<%% end %>
    <% end %>
  }),
  :pool => :htcpcp,
  :published => true,
  :published_at => "26-11-2013".to_datetime,
  :serie => :simple_decorator

@simple_decorator_2 = Blog::Screencast.create :user => @primal_user.blog_user,
  :summary => "Comme promis, un court épisode où on va tranformer notre décorateur (actuellement sous forme de classe) en module ! Pourquoi ? Parceque j'aime bien surcharger mes modèles et risquer du namespace collision à chaque nouvelle feature.",
  :embed => "G3lIIk22BYs",
  :snippet => Blog::Snippet.create(:erb => %q{
    <p>
      Decorator
    </p>
    
    <%= coderay do %>
# app/decorators/base_decorator.rb
module BaseDecorator
  def decorate! view_context
    @view_context = view_context

    class << self
      include DecoratorMethods
    end

    self
  end

  def h
    @view_context
  end
end

# app/decorators/todo_decorator.rb
module TodoDecorator
  include BaseDecorator

  module DecoratorMethods
    def completed
  		if super
        h.content_tag :span, "Completed", style: "color: green;"
  		else
  			'-'
  		end
    end
  end
end
    <% end %>
    
    <p>
      Model
    </p>
    
    <%= coderay do %>
# app/models/todo.rb
class Todo < ActiveRecord::Base
  attr_accessible :completed, :text

  include TodoDecorator
end
    <% end %>
    
    <p>
      Controller
    </p>
    
    <%= coderay do %>
# app/controllers/todo_controller.rb:show
@todo = Todo.find(params[:id]).decorate! view_context
    <% end %>
    
    <p>
      Helper
    </p>
    
    <%= coderay do %>
# app/helpers/application_helper.rb
module ApplicationHelper
  def decorate instance, &block
    capture do
      block.call instance.decorate!(self)
    end
  end
end
    <% end %>
    
    <p>
      View
    </p>
    
    <%= coderay lang: :erb do %>
<!-- app/views/todos/index.html.erb -->
<%%= decorate todo do |decorated_todo| %>
	<%%= decorated_todo.completed %>
<%% end %>
    <% end %>
  }),
  :pool => :htcpcp,
  :published => true,
  :published_at => "26-11-2013".to_datetime,
  :following => @simple_decorator_1
