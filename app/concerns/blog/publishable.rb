module Blog::Publishable
  extend ActiveSupport::Concern
  
  included do
    scope :published, where(published: true)
    
    validates_presence_of :published_at, if: :published
  end
end