class Blog::Version < ActiveRecord::Base
  attr_protected
  
  belongs_to :user
  
  belongs_to :experiment
  def experiment
    Blog::Experiment.with_version(self).first
  end
  delegate :to_url, to: :experiment
  
#mutation concern begin
  has_many :mutations, :class_name => "Blog::Version", :foreign_key => "version_id"
  belongs_to :primal, :class_name => "Blog::Version", :foreign_key => "version_id"
  
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
#mutation concern end

  default_scope order('rank ASC')
  scope :published, where(:published => true)
  scope :by_experiment, ->(experiment) do 
    where(:experiment_id => experiment)
  end
  
  validates_presence_of :user_id, :experiment_id, :rank
  validates_uniqueness_of :rank, :scope => :experiment_id
  
  
  #must validate codes blocks if primal
  #if no primal, must validate primal_id
  
  def code
    %Q{
      <%
        #{ params }
        #{ ruby }
      %>
      
      <%= scss %Q{#{ scss }} %>
      
      #{ erb }
    }
  end
end
