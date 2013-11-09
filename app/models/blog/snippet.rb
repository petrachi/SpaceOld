class Blog::Snippet < ActiveRecord::Base
  belongs_to :runnable, polymorphic: true
  
  include Blog::SnippetDecorator
  include Blog::Mutable.new mutables: %w(params ruby scss erb js)
  include Blog::Precompilable
    
  validates_presence_of :erb
  
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
