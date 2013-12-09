#!/bin/env ruby
# encoding: utf-8

@dsl_1 = Blog::Screencast.create :user => @primal_user.blog_user,
  :title => "My First DSL",
  :summary => "Cette fois-ci, on apprends comment intégrer une DSL (domain specific language) dans les 'models' de rails.",
  :embed => "UVPO_HYwGaA",
  :snippet => Blog::Snippet.create(:erb => %q{
    <p>
      Service - DSL
    </p>
    
    <%= coderay do %>
class Lifeform

  module Models
    def act_as_lifeform

      scope :first_form, where(id: 1)

      extend ClassMethods
      include InstanceMethods
    end

    module ClassMethods
      def specie„
        "#{ name }ies"
      end
    end

    module InstanceMethods
      def indentity
        "#{ self.class.specie } - #{ id }"
      end
    end
  end

  ActiveRecord::Base.extend Models
end
    <% end %>
    
    <p>
      Config
    </p>
    
    <%= coderay do %>
Dir[File.join(Rails.root, "app", "services", "*.rb")].each{ |path| require path }
    <% end %>
    
    <p>
      Models
    </p>
    
    <%= coderay do %>
class Todo < ActiveRecord::Base
  act_as_lifeform
end
    <% end %>
  }),
  :pool => :htcpcp,
  :published => true,
  :published_at => "08-12-2013".to_datetime,
  :tag => :my_first_dsl
  