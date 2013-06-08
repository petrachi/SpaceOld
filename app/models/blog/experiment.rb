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
    @version || versions.first
  end
  delegate :code, to: :version
  
  scope :published, where(:published => true)
  default_scope published
  
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
    @version = self.versions.mutant(mutation).first
    self
  end
  
  def with_primal_version
    @version = self.versions.mutant(nil).first
    self
  end
  
  validates_presence_of :user_id, :title, :summary
  validates_uniqueness_of :title
  
  def self.to_url
    URL.experiments_path
  end
  
  def to_url
    URL.experiment_path self, :version_id => self.version
  end
end
