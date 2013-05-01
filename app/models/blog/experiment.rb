class Blog::Experiment < ActiveRecord::Base
  attr_protected
  
  belongs_to :user, :foreign_key => :blog_user_id
  belongs_to :article, :foreign_key => :blog_article_id
  has_many :versions, :foreign_key => :blog_experiment_id
  has_many :ressources, :as => :source
  
  scope :published, where(:published => true)
  
  validates_presence_of :blog_user_id, :title, :summary, :code
  validates_uniqueness_of :title
  
  def code
    if versions.present?
      read_attribute(:code).gsub "<%# version %>", versions.first.code
    else
      read_attribute(:code)
    end
  end
  
end
