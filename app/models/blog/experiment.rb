class Blog::Experiment < ActiveRecord::Base
  attr_protected
  
  belongs_to :user, :foreign_key => :blog_user_id
  has_many :ressources, :as => :source
  
  scope :published, where(:published => true)
  
  validates_presence_of :blog_user_id, :title, :summary, :block
  validates_uniqueness_of :title
end
