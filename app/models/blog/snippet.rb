class Blog::Snippet < ActiveRecord::Base
  include Blog::Precompilable
  
  
  belongs_to :runnable, polymorphic: true
  
#mutation concern begin
  belongs_to :primal, :class_name => "Blog::Snippet", :foreign_key => "primal_id"
  has_many :mutations, :class_name => "Blog::Snippet", :foreign_key => "primal_id", conditions: "published = true"
  
  def params
    super || primal.try( :params)
  end
  
  def ruby
    super || primal.try( :ruby)
  end
  
  def scss
    super || primal.try( :scss)
  end
  
  def erb
    super || primal.try( :erb)
  end
  
  def js
    super || primal.try( :js)
  end
  
  def primal?
    primal.blank?
  end
  #disabled for now, must come back
  #validates_presence_of :params, :ruby, :scss, :erb, :js, if: :primal?
  #validates_presence_of :primal_id, :mutation, unless: :primal?
#mutation concern end

#must validate only one primal by experiment

  scope :published, where(:published => true)
  
  validates_uniqueness_of :mutation, :scope => :primal_id, :unless => :primal?
  
  def run mutation = nil
    if mutation
      mutations.where(mutation: mutation).first.run
    else
      compiled
    end
  end
  
  def raw
    %Q{
      <%
        #{ params }
        #{ ruby }
      %>
      
      <%= scss %Q{#{ scss }} %>
      
      #{ erb }
      
      <script type='text/javascript'>
        #{ js }
      </script>
    }
  end
end
