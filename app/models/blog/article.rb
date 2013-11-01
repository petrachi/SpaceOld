class Blog::Article < ActiveRecord::Base
  belongs_to :user
  
  has_one :snippet, as: :runnable, conditions: "published = true"
  delegate :run, to: :snippet
  
  has_one :followed, class_name: "Article", foreign_key: "following_id"
  belongs_to :following, class_name: "Article"
  
  scope :published, where(:published => true)  
  scope :pool, -> pool { where(:pool => pool) }
  
  
  validates_presence_of :user, :title, :summary, :snippet, :pool, :tag
  validates_presence_of :serie, if: :following
  
  
  
  # all thing from series need to be moved in concern or something, 
  # cause serie will be needed for screencasts and experiences(?)
  #
  # first only take serie + title
  # auto set tag
  ###
  # then, following do not include title nor tag nor serie, only following
  # serie + title + tag is set
  
  
  def tag_from_serie
    "#{ serie }_p#{ serial_number }"
  end
  
  before_validation :set_following, on: :create, if: :following
  def set_following
    p "set follow #{self}"
    self.title = following.title
    self.serie = following.serie
  end
  
  before_validation :set_serie, on: :create, if: :serie
  def set_serie
    p "set serie #{self}"
    self.tag = tag_from_serie
    true
  end
  
  
  
  
  validates_uniqueness_of :tag
  validates_inclusion_of :pool, :in => [:experience, :ruby, :css]
  
  
  def to_param() tag end
  def self.tagged(tag) where(tag: tag).first end
  
  def pool_url
    URL.blog_articles_path :pool => pool
  end
  
  
  
  def serial_number
    if following
      following.serial_number + 1
    else
      1
    end
  end
  
  
  
  
  # DECORATOR - need to be move
  def title_with_serie
    if serie
      "#{ title } <small><i>(vol #{ serial_number })</i></small>".html_safe
    else
      title
    end
  end
 
  
end
