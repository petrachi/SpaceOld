#!/bin/env ruby
# encoding: utf-8

@div_by_seven_1 = Blog::Screencast.create :user => @primal_user.blog_user,
  :title => "Div by 7",
  :summary => "Dans cet série, on va représenter un graphique en se basant sur une méthode facile qui permet de savoir si un nombre est divisible par 7. On pose les bases dans ce premier épisode.",
  :embed => "leA8jgCL_8E",
  :snippet => Blog::Snippet.create(:erb => %q{
    <%= coderay do %>
class Fixnum
  def prime?
    ("1" * self) !~ /^1?$|^(11+?)\1+$/
  end

  def digits
    to_s.chars.map(&:to_i)
  end

  def div_by_3?
    sum = digits.inject(0, :+)

    if sum > 9
      sum.div_by_3?
    else
      [3, 6, 9].include? sum
    end
  end
end
    <% end %>
  }),
  :pool => :try_hard,
  :published => true,
  :published_at => "14-11-2013".to_datetime,
  :serie => :div_by_7

@div_by_seven_2 = Blog::Screencast.create :user => @primal_user.blog_user,
  :summary => "On entre dans le vif du sujet, et on commence à créer les classes et méthodes qui nous permettrons de représenter notre graphe.",
  :embed => "pmC-naSadDw",
  :snippet => Blog::Snippet.create(:erb => %q{
    <%= coderay do %>
class Node
  attr_accessor :id, :final, :black_arrow, :white_arrow

  def initialize id, final, black_arrow = nil, white_arrow = nil
    @id, @final = id, final
    arrows = [black_arrow, white_arrow]
  end

  def arrows= arrows
    @black_arrow, @white_arrow = arrows
  end
end

class Graph
  def initialize nodes
    @nodes = nodes
  end
end

n0 = Node.new 0, true
n1 = Node.new 1, false
n2 = Node.new 2, false
n3 = Node.new 3, false
n4 = Node.new 4, false
n5 = Node.new 5, false
n6 = Node.new 6, false

n0.arrows = [n1, n0]
n1.arrows = [n2, n3]
n2.arrows = [n3, n6]
n3.arrows = [n4, n2]
n4.arrows = [n5, n5]
n5.arrows = [n6, n1]
n6.arrows = [n0, n4]
    <% end %>
  }),
  :pool => :try_hard,
  :published => true,
  :published_at => "14-11-2013".to_datetime,
  :following => @div_by_seven_1
  
@div_by_seven_3 = Blog::Screencast.create :user => @primal_user.blog_user,
  :summary => "Épisode final où notre graphe, puis sera légérement optimisé.",
  :embed => "qeMxwmASssE",
  :snippet => Blog::Snippet.create(:erb => %q{
    <%= coderay do %>
class Fixnum
  def prime?
    ("1" * self) !~ /^1?$|^(11+?)\1+$/
  end
  
  def digits
    to_s.chars.map(&:to_i)
  end
  
  def div_by_3?
    sum = digits.inject(0, :+)
    
    if sum > 9
      sum.div_by_3?
    else
      [3, 6, 9].include? sum
    end
  end
end

class Node
  attr_accessor :id, :final, :black_arrow, :white_arrow
  
  def initialize id, final, black_arrow = nil, white_arrow = nil
    @id, @final = id, final
    arrows = [black_arrow, white_arrow]
  end
  
  def arrows= arrows
    @black_arrow, @white_arrow = arrows
  end
end

class Graph
  def initialize nodes
    @nodes = nodes
  end
  
  def run value
    current_node = @nodes.first
    
    value.digits.each do |digit|
      digit.times do
        current_node = current_node.black_arrow
      end
      
      current_node = current_node.white_arrow
    end
    
    current_node.final
  end
end

class Fixnum
  n0 = Node.new 0, true
  n1 = Node.new 1, false
  n2 = Node.new 2, false
  n3 = Node.new 3, false
  n4 = Node.new 4, false
  n5 = Node.new 5, false
  n6 = Node.new 6, false

  n0.arrows = [n1, n0]
  n1.arrows = [n2, n3]
  n2.arrows = [n3, n6]
  n3.arrows = [n4, n2]
  n4.arrows = [n5, n5]
  n5.arrows = [n6, n1]
  n6.arrows = [n0, n4]

  GRAPH_7 = Graph.new [n0, n1, n2, n3, n4, n5, n6]

  def div_by_7?
    GRAPH_7.run self
  end
end
    <% end %>
  }),
  :pool => :try_hard,
  :published => true,
  :published_at => "14-11-2013".to_datetime,
  :following => @div_by_seven_2
  