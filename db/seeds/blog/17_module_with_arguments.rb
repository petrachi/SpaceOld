#!/bin/env ruby
# encoding: utf-8

@module_with_arguments_1 = Blog::Screencast.create :user => @primal_user.blog_user,
  :title => "Module with Arguments",
  :summary => "Les modules, c'est la réponse de ruby à l'héritage multiple. Personnellement j'aime bien, mais le problème avec les modules, c'est qu'ils sont un peu trop ... statiques. Et si on ajoutait un peu de méta-programmation à tout ça ?",
  :embed => "-MiV8nhq8KU",
  :snippet => Blog::Snippet.create(:erb => %q{
    <p>
      Module
    </p>
    
    <%= coderay do %>
# app/concerns/prefixable.rb
class Prefixable < Module

  def initialize prefixs = {}
    @prefixs = prefixs
    @attributes = prefixs.keys
  end

  def included base
    super
    define_instance_methods @prefixs
  end

  def define_instance_methods prefixs
    @attributes.each do |attribute|
      define_method "prefixed_#{ attribute }" do
        "#{ prefixs[attribute] } : #{ send(attribute) }"
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
include Prefixable.new title: "Summary", text: "Task", owner: "Remeber my name"
    <% end %>
    
    
    <p>
      View
    </p>
    
    <%= coderay lang: :erb do %>
<!-- app/views/todos/index.html.erb -->
<td><%%= todo.prefixed_title %></td>
<td><%%= todo.prefixed_text %></td>
<td><%%= todo.completed %></td>
<td><%%= todo.prefixed_owner %></td>
    <% end %>
  }),
  :pool => :htcpcp,
  :published => true,
  :published_at => "29-11-2013".to_datetime,
  :tag => :module_with_arguments
