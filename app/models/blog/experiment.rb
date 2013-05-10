class Blog::Experiment < ActiveRecord::Base
  attr_protected
  
  belongs_to :user
  belongs_to :article
  has_many :versions
  def version
    versions.first
  end
  delegate :code, to: :version
  
  scope :published, where(:published => true)
  scope :with_version, ->(version) do
    includes(:versions).where(:blog_versions => {:id => version})
  end
  scope :with_ranked_version, ->(rank) do
    includes(:versions).where(:blog_versions => {:rank => rank})
  end
  scope :with_primal_version, -> do
    with_ranked_version 1
  end
  
  validates_presence_of :user_id, :title, :summary
  validates_uniqueness_of :title
  
  def self.to_url
    URL.experiments_path
  end
  
  def to_url
    URL.experiment_path self, self.version
  end
end
