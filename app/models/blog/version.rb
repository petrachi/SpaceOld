class Blog::Version < ActiveRecord::Base
  attr_protected
  
  belongs_to :experiment
  def experiment
    Blog::Experiment.with_version(self).first
  end
  
  scope :published, where(:published => true)
  scope :by_experiment, ->(experiment) do 
    where(:experiment_id => experiment)
  end
  
  validates_presence_of :experiment_id, :title, :code
  validates_uniqueness_of :title, :scope => :experiment_id
  
  delegate :to_url, to: :experiment
end
