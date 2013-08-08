class Blog::Version < ActiveRecord::Base
  attr_protected
  
  belongs_to :user
  
  belongs_to :experiment
  def experiment
    Blog::Experiment.with_version(self).first
  end
  delegate :to_url, to: :experiment
  
#mutation concern begin
  has_many :mutations, :class_name => "Blog::Version", :foreign_key => "primal_id"
  belongs_to :primal, :class_name => "Blog::Version", :foreign_key => "primal_id"
  
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
  
  validates_presence_of :params, :ruby, :scss, :erb, :js, if: :primal?
  validates_presence_of :primal_id, :mutation, unless: :primal?
#mutation concern end

#must validate only one primal by experiment


  scope :published, where(:published => true)
  default_scope published
  
  scope :by_experiment, ->(experiment) do 
    where(:experiment_id => experiment)
  end
  
  validates_presence_of :user_id, :experiment_id
  validates_uniqueness_of :mutation, :scope => :experiment_id
  
  
  def code
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
