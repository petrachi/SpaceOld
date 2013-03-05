class Blog::User < ActiveRecord::Base
  belongs_to :main_user
  # attr_accessible :title, :body
end
