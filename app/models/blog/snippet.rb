class Blog::Snippet < ActiveRecord::Base
  belongs_to :runnable, polymorphic: true
  
  acts_as_decorables
  
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
  
  def precompiled_md5
    Digest::MD5.hexdigest [params, ruby, scss, erb, js].join
  end
  
  def tag
    runnable.tag << "_#{ mutation }" if mutation
  end
  
  def raw
    %Q{
      <%
        #{ params }
        #{ ruby }
      %>
      
      <%= scss %Q{
        #snippet-#{ precompiled_md5 }{
          #{ scss }
        }
      } %>
      
      <div id="snippet-#{ precompiled_md5 }">
        #{ erb }
      </div>
      
      <script type='text/javascript'>
        #{ js }
      </script>
    }
  end
end
