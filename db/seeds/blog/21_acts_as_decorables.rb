#!/bin/env ruby
# encoding: utf-8

Blog::Screencast.create :user => @primal_user.blog_user,
  :title => "Acts as decorables",
  :summary => "Dans cet épisode on se sert de nos acquis pour transformer notre classe <i>decorator</i> en une vraie mini-librairie, DSL incluse, c'est cadeau.",
  :embed => "CmdeknAOUnQ",
  :snippet => Blog::Snippet.create(:erb => %q{
    <p>
      Service
    </p>

    <%= coderay do %>
module Decorator
  class Base < SimpleDelegator
    def initialize base, view_context
      super(base)

      @view_context = view_context
    end

    def h
      @view_context
    end
  end
end
    <% end %>
    
    <p>
      DSL
    </p>

    <%= coderay do %>
module Decorator
  module Models
    def acts_as_decorables const = nil, &block
      if block_given?
        decorator_class = Class.new(Decorator::Base, &block)
        name.deconstantize.constantize.const_set "#{ name.demodulize }Decorator", decorator_class
        @const = "#{ name }Decorator".constantize
      else
        @const = const || "#{ name }Decorator".constantize
      end

      extend ClassMethods
      include InstanceMethods
    end

    module ClassMethods
      def decorator_class
        @const
      end
    end

    module InstanceMethods
      def decorate view_context
        self.class.decorator_class.new self, view_context
      end
    end
  end
end
    <% end %>
    
    <p>
      Initializer
    </p>

    <%= coderay do %>
ActiveRecord::Base.extend Models
    <% end %>
    
    <p>
      Model
    </p>

    <%= coderay do %>
class Todo < ActiveRecord::Base
  acts_as_decorables do
    def completed
  		if super
        h.content_tag :span, "Completed", style: "color: green;"
  		else
  			'-'
  		end
    end
  end

  attr_accessible :title, :completed, :text, :owner
end
    <% end %>
    
    <p>
      Controller
    </p>

    <%= coderay do %>
@todos = Todo.all.map do |todo|
  todo.decorate view_context
end
    <% end %>
  }),
  :pool => :htcpcp,
  :published => true,
  :published_at => "15-01-2014".to_datetime,
  :tag => :acts_as_decorables
  