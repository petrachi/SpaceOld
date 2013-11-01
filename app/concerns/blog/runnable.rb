module Blog::Runnable
  extend ActiveSupport::Concern
  
  included do
    has_one :snippet, as: :runnable, conditions: "published = true"
    delegate :run, to: :snippet
    
    validates_presence_of :snippet
  end
end
