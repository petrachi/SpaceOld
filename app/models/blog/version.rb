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
  scope :by_experiment, ->(experiment) do 
    where(:experiment_id => experiment)
  end
  
  validates_presence_of :user_id, :experiment_id
  validates_uniqueness_of :mutation, :scope => :experiment_id
  
  
  
  def code
    %Q{
      <%
        #{ ruby }
        #{ params }
      %>
      
      <%= scss %Q{#{ scss }} %>
      
      #{ erb }
      
      <script type='text/javascript'>
        #{ js }
      </script>
    }
  end
end
