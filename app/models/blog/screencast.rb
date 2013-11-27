class Blog::Screencast < ActiveRecord::Base
  belongs_to :user
  
  include Blog::ScreencastDecorator
  include Blog::Paginable
  include Blog::Poolable.new inclusion_in: [:try_hard, :htcpcp]
  include Blog::Publishable
  include Blog::Runnable
  include Blog::Seriable
  include Blog::Taggable
  
  validates_presence_of :user, :title, :summary, :embed, :snippet
  validates_uniqueness_of :embed
  
  
  
  # should be helper, (or service ? /services/paginator)
  def self.pagination page, per
    nb_pages = self.count / per
    nb_pages += 1

    buf = ""
    nb_pages.times do |i|

      if i+1 == page
        buf += "<span>#{i+1}</span>"
      else
        buf += "<a href='/screencasts/page-#{i+1}'>#{i+1}</a>"
      end
    end

    buf.html_safe
  end
end
