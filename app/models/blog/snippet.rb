class Blog::Snippet < Snippet
  # these two must not be in blog
  include Blog::Mutable.new mutables: %w(params ruby scss erb js)
  include Blog::Precompilable
end
