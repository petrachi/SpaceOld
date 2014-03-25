class Blog::Article < ActiveRecord::Base
  belongs_to :user

  acts_as_decorables
  act_as_paginable

  include Blog::Poolable.new inclusion_in: [:experience, :ruby, :css, :quicktip]
  include Blog::Publishable
  include Runnable
  include Blog::Seriable
  include Blog::Taggable

  validates_presence_of :user, :title, :summary
end
