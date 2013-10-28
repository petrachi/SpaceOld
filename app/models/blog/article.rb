class Blog::Article < ActiveRecord::Base
  belongs_to :user
  
  has_one :snippet, as: :runnable, conditions: "published = true"
  delegate :run, to: :snippet
  
  has_one :followed, class_name: "Article", foreign_key: "following_id"
  belongs_to :following, class_name: "Article"
  
  scope :published, where(:published => true)  
  scope :pool, -> pool { where(:pool => pool) }
  
  
  validates_presence_of :user, :title, :summary, :snippet, :pool, :tag
  validates_uniqueness_of :tag
  validates_inclusion_of :pool, :in => [:experiment, :ruby, :css]
  
  
  def to_param() tag end
  def self.tagged(tag) where(tag: tag).first end
  
  def pool_url
    URL.blog_articles_path :pool => pool
  end
  
  
  def serial?
    followed or following
  end
  
  def serial_number
    if following
      following.serial_number + 1
    else
      1
    end
  end
  
  
  
  
  # DECORATOR - need to be move
  def title
    if serial?
      @attributes["title"] + " - #{I18n.t "blog.name"} part " + serial_number.to_s
    else
      @attributes["title"]
    end
  end
 
  
end
