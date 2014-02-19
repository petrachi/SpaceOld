#!/bin/env ruby
# encoding: utf-8

screencast = Blog::Screencast.create :user => @primal_user.blog_user,
  :title => "Un grid en CSS3",
  :summary => "Aujourd'hui, on fait du css, on fait du flexbox, et on fait un grid. Cette technique de layout va nous permettre de gérer plus facilement l'alignement des différents éléments de notre page html.",
  :embed => "0rvDDfldCpw",
  :snippet => Blog::Snippet.create(:erb => %q{
    <p>
      HTML
    </p>

    <%= coderay lang: :html do %>
<div class="container">
  <div class="row">
    <div class="col-6"><h1>half</h1></div>
    <div class="col-6">half</div>
  </div>

  <div class="row">
    <div class="col-3">quart</div>
    <div class="col-3">quart</div>
    <div class="col-3">quart</div>
    <div class="col-3">quart</div>
  </div>

  <div class="row">
    <div class="col-4">tier</div>
    <div class="col-8">2-tier</div>
  </div>

  <div class="row">
    <div class="col-2">1/6</div>
    <div class="col-2">1/6</div>
    <div class="col-8">2-tier</div>
  </div>
</div>
    <% end %>
  }),
  :pool => :htcpcp,
  :published => true,
  :published_at => "19-02-2014".to_datetime,
  :serie => :css_grid

screencast = Blog::Screencast.create :user => @primal_user.blog_user,
  :summary => "On met en place le css du grid en utilisant le précompiler scss inclus par défault dans rails (>= 3.x)",
  :embed => "sHljOSbgY6c",
  :snippet => Blog::Snippet.create(:erb => %q{
    <p>
      Grid CSS (SCSS)
    </p>
    
    <%= coderay lang: :css do %>
.container{
  $base_width: 8px;

  width: $base_width * 8 * 12 - $base_width * 2;
  margin: auto;

  .row{

    margin: 0 -#{ $base_width };
    display: flex;
    align-items: baseline;

    @for $i from 1 through 12 {

      .col-#{ $i }{
  
        flex-shrink: 0;
        width: $base_width * 8 * $i - $base_width * 2;
        margin: 0 $base_width;
  
      }
    }
  }
}
    <% end %>
  }),
  :pool => :htcpcp,
  :published => true,
  :published_at => "19-02-2014".to_datetime,
  :following => screencast

screencast = Blog::Screencast.create :user => @primal_user.blog_user,
  :summary => "Épisode final où on met en place un helper pour faciliter la création des différents tags html liés au grid.",
  :embed => "f-vXZjmQG2U",
  :snippet => Blog::Snippet.create(:erb => %q{
    <p>
     HTML (ERB)
    </p>
  
    <%= coderay lang: :erb do %>
<%%= container_3_tag [1, "2", [3], {4 => 5}] do |elt| %>
  <%%= elt.class %>
<%% end %>
    <% end %>
    
    <p>
     Helper
    </p>
  
    <%= coderay do %>
module ApplicationHelper

  def container_tag &block
    content_tag :div, class: :container, &block
  end

  def row_tag &block
    content_tag :div, class: :row, &block
  end

  def col_tag col_size, &block
    content_tag :div, class: "col-#{ col_size }", &block
  end

  def container_3_tag collection, &block
    container_tag do
      row_tag do
  
        collection.map do |elt|
          col_tag 3 do
            capture do
              block.call(elt)
            end
          end
        end.reduce(:concat)
  
      end
    end
  end
end
    <% end %>
    
    <p>
      <%= btn_to "RKit on github", "https://github.com/petrachi/r_kit/blob/master/lib/r_kit/grid/action_view_extension.rb", target: :_blank %>
      Un exemple de helper plus complet.
    </p>
  }),
  :pool => :htcpcp,
  :published => true,
  :published_at => "19-02-2014".to_datetime,
  :following => screencast
