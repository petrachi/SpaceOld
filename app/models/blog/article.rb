class Blog::Article < ActiveRecord::Base
  belongs_to :user
  
  has_one :snippet, as: :runnable, conditions: "published = true"
  delegate :run, to: :snippet
  
  has_one :followed, class_name: "Article", foreign_key: "following_id"
  belongs_to :following, class_name: "Article"
  
  scope :published, where(:published => true)  
  scope :pool, -> pool { where(:pool => pool) }
  
  
  validates_presence_of :user, :summary, :snippet, :pool
  validates_presence_of :title, :tag, unless: :following
  
  before_create :set_inheritance_serials, if: :following
  def set_inheritance_serials
    self.title ||= following.read_attribute :title
    m = following.tag.to_s.match /^(.*)_p\d+$/

    self.tag = m[1]
  end
  
  attr_accessor :serial_anticiped
  before_create :set_tag_serials, if: "serial? or serial_anticiped"
  def set_tag_serials
    p "tag special"
    self.tag = tag.to_s + "_p" + serial_number.to_s
    
    p self.tag
    true
  end
  
  before_validation :youpi, if: :serial_anticiped
  def youpi
    p "hahahah"
  end
  
  validates_uniqueness_of :tag
  validates_inclusion_of :pool, :in => [:experience, :ruby, :css]
  
  
  def to_param() tag end
  def self.tagged(tag) where(tag: tag).first end
  
  def pool_url
    URL.blog_articles_path :pool => pool
  end
  
  
  def serial?
    following or followed
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
    return nil if @attributes["title"].blank?
    if serial?
      @attributes["title"] + " - part " + serial_number.to_s
    else
      @attributes["title"]
    end
  end
 
  
end
