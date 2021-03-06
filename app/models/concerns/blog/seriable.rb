module Blog::Seriable
  extend ActiveSupport::Concern

  included do
    has_one :followed, class_name: name, foreign_key: "following_id"
    belongs_to :following, class_name: name
    
    before_validation :set_following, on: :create, if: :following
    before_validation :set_serie, on: :create, if: :serie
    
    validates_presence_of :serie, if: :following
    validates_uniqueness_of :following_id, if: :following
    
    scope :serie, -> serie { where(serie: serie) }
    scope :firsts_of_series, where(following_id: nil)
  end
  
  def set_following
    self.title = following.title
    self.serie = following.serie
  end
  
  def set_serie
    self.tag = "#{ serie }_#{ serial_number }"
  end
  
  def serial_number
    following ? following.serial_number + 1 : 1
  end
  
  def serie_url
    URL.send "#{ ActiveModel::Naming.route_key self.class }_path", serie: serie
  end
  
  def serie_collection
    self.class.where(serie: serie)
  end
  
  def serie_size
    serie_collection.count
  end
end