#!/bin/env ruby
# encoding: utf-8

@simple_delegator_1 = Blog::Screencast.create :user => @primal_user.blog_user,
  :title => "My Simple Delegator",
  :summary => "On a déjà abordé les 'delegator' lors de l'épisode sur les decorateurs, aujourdh'hui on va tenter de comprendre comment ça marche.",
  :embed => "hIpx-MDfAAc",
  :snippet => Blog::Snippet.create(:erb => %q{
    <%= coderay do %>
class MySimpleDelegator
  def initialize obj
    @base_obj = obj
  end


  def __getobj__
    @base_obj
  end

  def __setobj__ obj
    @base_obj = obj
  end


  def methods
    @base_obj.methods | super
  end


  def method_missing method_name, *args, &block
    if @base_obj.respond_to? method_name
      @base_obj.send method_name, *args, &block
    else
      super
    end
  end
end
    <% end %>
    
    <%= coderay do %>
class StringArray < MySimpleDelegator
  undef :inspect

  def initialize base
    super base
    __setobj__ __getobj__.map(&:to_s)
  end
end


?> array = [1, 2, 3, 4, "a", "b", :c]
=> [1, 2, 3, 4, "a", "b", :c]

?> s_array = StringArray.new array
=> ["1", "2", "3", "4", "a", "b", "c"]
    <% end %>
  }),
  :pool => :htcpcp,
  :published => true,
  :published_at => "08-12-2013".to_datetime,
  :tag => :simple_delegator
