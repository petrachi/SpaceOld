class Blog::Experiment < ActiveRecord::Base
  attr_protected
  
  belongs_to :user
  belongs_to :article
  has_many :versions do
    def mutant mutation
      where(:blog_versions => {:mutation => mutation})
    end
  end
  def version
    versions.first
  end
  delegate :code, to: :version
  
  scope :published, where(:published => true)
  scope :with_version, ->(version) do
    includes(:versions).where(:blog_versions => {:id => version})
  end
  scope :with_mutant_version, ->(mutation) do
    includes(:versions).where(:blog_versions => {:mutation => mutation})
  end
  scope :with_primal_version, -> do
    with_mutant_version nil
  end
  
  def with_mutant_version mutation
    self.versions = self.versions.mutant mutation
    self
  end
  
  def with_primal_version
    self.versions = self.versions.mutant nil
    self
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
