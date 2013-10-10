class Blog::Snippet < ActiveRecord::Base
  belongs_to :runnable, polymorphic: true
  
#mutation concern begin
  belongs_to :primal, :class_name => "Blog::Snippet", :foreign_key => "primal_id"
  has_many :mutations, :class_name => "Blog::Snippet", :foreign_key => "primal_id"
  
  def params
    super || primal.params
  end
  
  def ruby
    super || primal.ruby
  end
  
  def scss
    super || primal.scss
  end
  
  def erb
    super || primal.erb
  end
  
  def js
    super || primal.js
  end
  
  def primal?
    primal.blank?
  end
  #disabled for now, must come back
  #validates_presence_of :params, :ruby, :scss, :erb, :js, if: :primal?
  #validates_presence_of :primal_id, :mutation, unless: :primal?
#mutation concern end

#must validate only one primal by experiment

  scope :published, where(:published => true)
  
  validates_uniqueness_of :mutation, :scope => :primal_id, :unless => :primal?
  
  #before_save :precompile_scss!
  def precompile_scss!
    if Digest::MD5.hexdigest(scss) != scss_md5
      write_attribute :scss_md5, Digest::MD5.hexdigest(scss)
    
    
      context_scss = ERB.new(%Q{
        <%
          #{ params }
          #{ ruby }
        %>

        <%= %Q{#{ scss }} %>
      }).result
    
    
    
      #this code is duplicate from erb helper - it needs to be refactor
      write_attribute :precompiled_scss, Sass::Engine.new(
        %Q{
          @import "r_kit/variables";
          @import "r_kit/mixins";
          @import "r_kit/animations";

          @import "blog/variables";
          @import "compass";
        } + context_scss, 
        :syntax => :scss,
        :load_paths => [
          File.join(Rails.root, "app/assets/stylesheets"),
          File.join(Rails.root, "lib/assets/stylesheets"),
          File.join(Gem.loaded_specs['compass'].full_gem_path, "frameworks/compass/stylesheets"),
          File.join(Gem.loaded_specs['compass'].full_gem_path, "frameworks/blueprint/stylesheets")
        ]
      ).render
    
      save!
    end
  end
  
  def precompiled_scss
    
    
    precompile_scss!
    read_attribute :precompiled_scss  
    
  end
  
  #the content tag for css here could be in erb_helper, or already exist in rails
  # and, this lead to the code below to be describe in a "decorator", who have access to rails views helpers
  
  #orig is <%= scss %Q{#{ scss }} %>
  
  #<style type="text/css">#{ precompiled_scss }</style>
  #precompiling doesn't work because scss need erb to evaluate ruby before compiling scss
  #(variables ruby injected in scss to calc the width for ex in experiment 2 hexagones)
  def run mutation = nil
    # if mutation, display the mutation precompiled
    
    %Q{
      <%
        #{ params }
        #{ ruby }
      %>
      
      <%= scss %Q{#{ scss }} %>
      
      #{ erb }
      
      <script type='text/javascript'>
        #{ js }
      </script>
    }

# mode track time
# reveal today => scss is 0.3s min (vs .8e-07 for all others)
# ruby can jump to .003 (big calc "sphere" style)
# scss can jump to 3s !!! (on "sphere") 
=begin    
    %Q{
      <%
      t1 = Time.now
        #{ params }
        t2=Time.now
        #{ ruby }
        t3=Time.now
      %>
      
      <%= scss %Q{#{ scss }} %>
      <% t4=Time.now %>
      #{ erb }
      <% t5=Time.now %>
      <script type='text/javascript'>
        #{ js }
      </script>
      <% t6=Time.now 
      
      p "param " + (t2 - t1).to_s
      p "ruby " + (t3 - t2).to_s
      p "scss " + (t4 - t3).to_s
      p "erb " + (t5 - t4).to_s
      p "js " + (t6 - t5).to_s
      
      %>
    }
=end
  end
end
