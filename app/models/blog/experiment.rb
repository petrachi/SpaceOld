class Blog::Experiment < ActiveRecord::Base
  attr_protected
  
  belongs_to :user
  belongs_to :article
  has_many :versions
  
  scope :published, where(:published => true)
  scope :with_version, ->(version) do
    includes(:versions).where(:blog_versions => {:id => version})
  end
  
  validates_presence_of :user_id, :title, :summary, :code
  validates_uniqueness_of :title
  
  # TODO: Delegate in versions
  def code
    if versions.present?
      read_attribute(:code).gsub "<%# version %>", versions.first.code
    else
      read_attribute(:code)
    end
  end
  
  def self.to_url
    URL.experiments_path
  end
  
  def to_url
    URL.experiment_path self, self.versions.try(:first)
  end
end
