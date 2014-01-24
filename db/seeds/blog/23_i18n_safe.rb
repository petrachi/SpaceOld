#!/bin/env ruby
# encoding: utf-8

x = Blog::Article.create :user => @primal_user.blog_user,
  :title => "I18n + html_safe ?",
  :summary => %q{
    Avec rails 3, les strings sont par défaut "unsafe". C'est très bien pour éviter une injection XSS. Mais pour les clés I18n, qui proviennent d'un environnement contrôlé, il n'existerait pas une petite technique à la pisse des bois pour éviter de toujours répéter <i>.html_safe</i> ?
  },
  :snippet => Blog::Snippet.create(erb: %q{
    <p>
      Je connais deux techniques pour récupérer les valeurs des clés I18n comme des instances d'<%= coderay({inline: true}, "ActiveSupport::SafeBuffer") %>, et ainsi éviter de chainer l'appel à <%= coderay({inline: true}, ".html_safe") %>. C'est le sujet aujourd'hui.<br/>
      Au fait, ça va vous ? La famille, bien ?
    </p>
    
    <h3>Clés I18n</h3>
    
    <p>
      La première solution, la plus commune, consiste à ajouter <%= coderay({inline: true}, "_html") %> ou <%= coderay({inline: true}, ".html") %> à la fin du nom des clés qui contiennent du html.
    </p>
    
    <p>
      Voici un fichier <%= coderay({inline: true}, ".yml") %> que nous allons utiliser comme exemple :
    </p>
    
    <%= coderay lang: :yml do %>
previous: "&larr; Previous"
next: "Next &rarr;"

previous_html: "&larr; Previous"
next_html: "Next &rarr;"

# or
previous:
html: "&larr; Previous"
next:
html: "Next &rarr;"
    <% end %>
    
    <p>
      Grâce à quelque "black magic", les clés indentifiées comme 'html' seront automatiquement <%= coderay({inline: true}, "html_safe") %>ysées. Direct la démo qui va bien (btw, dans la console, le mot clé <%= coderay({inline: true}, "helper") %> vous permet d'accéder aux méthodes de helpers de rails) :
    </p>
    
    <%= coderay do %>
?> helper.t :previous
=> "&larr; Previous"

?> helper.t :previous_html
=> "← Previous"
    <% end %>
    
    <h3>Enter the Magic</h3>
    
    <p>
      Alors moi, d'un autre côté, j'aime pas trop ça la "black magic", du coup je suis allé voir le fonctionnement du helper <%= coderay({inline: true}, "t") %> (ou <%= coderay({inline: true}, "translate") %>).
    </p>
    
    <%= coderay do %>
def translate(key, options = {})
# ... some code
if html_safe_translation_key?(key)
  # ... some other code
  translation.respond_to?(:html_safe) ? translation.html_safe : translation
else
  I18n.translate(scope_key_by_partial(key), options)
end
end
    <% end %>
    
    <p>
      Donc, ce helper va appliquer la méthode <%= coderay({inline: true}, "html_safe") %> en fonction de ce que lui indique une autre méthode : <%= coderay({inline: true}, "html_safe_translation_key?") %>. C'est là qu'on va pouvoir influencer le comportement de rails.
    </p>
    
    <h3>Monkey Patching</h3>
    
    <p>
      Afin de déclarer TOUTES les clés du monde comme valide pour du <%= coderay({inline: true}, "html_safe") %>, on va direct overrider la méthode <%= coderay({inline: true}, "html_safe_translation_key?") %> pour qu'elle renvoie toujours <%= coderay({inline: true}, "true") %>.
    </p>
    
    <%= coderay do %>
module ActionView
module Helpers
  module TranslationHelper
    private
    def html_safe_translation_key?(key)
      true
    end
  end
end
end
    <% end %>
    
    <p>
      Ça y est, toutes mes clés sont <%= coderay({inline: true}, "html_safe") %>, toutes mes valeurs sont des <%= coderay({inline: true}, "ActiveSupport::SafeBuffer") %>, on a fini le boulot. Je peux rentrer chez moi, et vous chez vous.
    </p>
    
    <h3>Monkey Patching Safe</h3>
    
    <p>
      Juste, avant de partir, penser bien à utiliser le helper <%= coderay({inline: true}, "t") %>, et pas la méthode <%= coderay({inline: true}, "I18n.t") %> directement.<br/>
      Et je déconseille d'overrider directement la méthode <%= coderay({inline: true}, "I18n.t") %>, à cause des paramètres qu'on peut passer aux clés. Je vous met une démo pour bien comprendre :
    </p>
    
    <%= coderay lang: :yml do %>
name: "<strong>Nom</strong> : %{name}"
    <% end %>
    
    <%= coderay do %>
?> bdd_value = "Thomas <span>El</span> Petrachi"

# rails helper override
?> helper.t :name, name: bdd_value
=> "<strong>Nom</strong> : Thomas &lt;span&gt;El&lt;/span&gt; Petrachi"

# direct I18n override
?> I18n.t :name, name: bdd_value
=> "<strong>Nom</strong> : Thomas <span>El</span> Petrachi" # This is XSS injection,
                                                          # html_safe has failed
    <% end %>
    
    <h3>Require</h3>
    
    <p>
      Aussi, pour que votre override fonctionne, pensez à <%= coderay({inline: true}, "require") %> le fichier dans lequel vous avez écrit votre monkey patch. Simplement ajouter le dossier du fichier dans la <%= coderay({inline: true}, "config.autoload_paths") %> ne fonctionnera pas.<br/>
      Pour faire ça, vous pouvez, par exemple, ajouter un fichier <i>config/initializers/require.rb</i> dans le genre :
    </p>
    
    <%= coderay do %>
Dir[File.join(Rails.root, "app", "extends", "**", "*.rb")].each{ |path| require path }    
    <% end %>
    
    <h3>Conclusion</h3>
    
    <p>
      C'est déjà fini les amis :(<br/>
      Mais on se retrouve bientôt pour parler de plein d'autres trucs, et en attendant, fini les ennuis de <%= coderay({inline: true}, "html_safe") %> en environement contrôlé !
    </p>
  }),
  :pool => :ruby,
  :published => true,
  :published_at => "24-01-2014".to_datetime,
  :tag => :i18n_safe
  