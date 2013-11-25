#!/bin/env ruby
# encoding: utf-8

@color_blender_article = Blog::Article.create :user => @primal_user.blog_user,
  :title => "Color Blender",
  :summary => %q{
    On prend deux couleurs, on les mixe, et on obtient un dégradé parfaitement génial (mais le code est tout à fait dégueulasse).
  },
  :snippet => Blog::Snippet.create(erb: %q{
			<p>
				Salut les p'tit amis,<br/>
				Aujourd'hui on va se programmer un petit algorithme de création de dégradé, ou 'color blender', et on va le faire en ruby, parceque c'est fun !
			</p>
			
			<h3>Format de couleur</h3>
			
			<p>
				On va utiliser deux formats de couleurs pour notre algorithme, du <%= coderay({:inline => true}, "RGB()") %> pour manipuler les valeurs, parceque manipuler des décimales c'est quand même plus sympa, et puis de l'<%= coderay({:inline => true}, "hexadécimal") %> pour le format de sortie, parceque je trouve que l'hexa c'est plus joli. À titre d'exemple, le rouge utilise sur ce site donne en rgb quelquechose comme <%= coderay({:inline => true}, "(182, 43, 43)") %>, et en hexa <%= coderay({:inline => true}, "#b62b2b") %>.
			</p>
			
			<p>
				Tout ça nous donner l'occasion de travailler sur deux petites fonctions de conversion !
			</p>
			
			<%= coderay do %>
def hex_to_rgb hex
	hex =~ /#(..)(..)(..)/
	{r: $1.hex, v: $2.hex, b: $3.hex}
end

def rgb_to_hex rgb
	"##{"%02x" % rgb[:r]}#{"%02x" % rgb[:v]}#{"%02x" % rgb[:b]}"
end
			<% end %>
			
			<h3>Color diff + pourcentages</h3>
			
			<p>
				On rentre dans le vif du sujet maintenant. Il faudra d'abord calculer la différence des valeurs entre les deux couleurs passées en paramètres (notés <%= coderay({:inline => true}, "from, to") %>).
			</p>
			
			<%= coderay do %>
def diff_color from, to
	{
		r: to[:r] - from[:r],
		v: to[:v] - from[:v],
		b: to[:b] - from[:b]
	}
end
			<% end %>
			
			<p>
				Ensuite, nous allons pouvoir progresser lentement, à partir de la première couleur, vers la seconde, en appliquant une portion donnée de la différence entre les deux couleurs.
			</p>
			
			<%= coderay do %>
def blend_color from, diff, progress
	{
		r: from[:r] + diff[:r] * progress,
		v: from[:v] + diff[:v] * progress,
		b: from[:b] + diff[:b] * progress
	}
end
			<% end %>
			
			<p>
				Allez on se lance, je vous montre vite fait ce qu'on peut obtenir avec une valeur de <%= coderay({:inline => true}, "progress") %> qui varie, et les couleurs <%= coderay({:inline => true}, "from: '#A21111', to: '#D3A80D'") %>.
			</p>
			
			<%= erb Blog::Experience.tagged(:color_clock).run(:diff_blender) %>
			
			<h3>Unification dans le blender</h3>
			
			<p>
				Nous avons toutes les composantes pour notre fonction de color blender, il suffit juste d'un petit itérateur : 
			</p>
			
			<%= coderay do %>
def blender from, to, steps
	blender = Array.new

	from = hex_to_rgb color_stops.shift
	to = hex_to_rgb color_stops.first

	diff = diff_color from, to

	steps.times do |i|
		progress = percent i, steps

		blended = blend_color from, diff, progress
		blender << rgb_to_hex(blended)
	end

	blender
end
			<% end %>
			
			<p>
				Si on fait un test rapide avec <%= coderay({:inline => true}, "blender '#A21111', '#D3A80D', 168") %>
			</p>
			
			<%= erb Blog::Experience.tagged(:color_clock).run(:only_blender) %>
			
			<h3>Color stops</h3>
			
			<p>
				Avant de conclure, je vous montre une rapide amélioration de qui permet de passer plus de deux couleurs en un seul appel.
			</p>
			
			<%= coderay do %>
def blender color_stops, steps
	blender = Array.new

	begin
		from = hex_to_rgb color_stops.shift
		to = hex_to_rgb color_stops.first

		diff = diff_color from, to

		steps.times do |i|
			progress = percent i, steps

			blended = blend_color from, diff, progress

			p "progress #{progress} - #{blended}"

			blender << rgb_to_hex(blended)
		end
	end while color_stops.size > 1

	blender
end
			<% end %>
			
			<p>La démo qui va bien avec <%= coderay({:inline => true}, "blender %w(#063186 #A21111 #D3A80D #28A528), 56") %></p>
			
			<%= erb Blog::Experience.tagged(:color_clock).run(:multiple_blender) %>
			
			<h3>Conclusion</h3>
			
			<p>
				Voilà, c'est fini, et on a un color blender simple et vite fait.
			</p>
			
			<p>
				On pourrait bien sûr améliorer cette fonction, mais pour ma part, j'estime qu'elle a fait son usage. Je l'ai originellement développé pour l'expérience du 'color clock', et elle me suffit amplement comme ça !
			</p>
			
			<p>
				Allez, bisous. Filez jouer maintenant !
			</p>
  }),
  :pool => :ruby,
  :published => true,
  :published_at => "25-11-2013".to_datetime,
  :tag => :color_blender
