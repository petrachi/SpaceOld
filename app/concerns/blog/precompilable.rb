module Blog::Precompilable
  extend ActiveSupport::Concern
  
  included do
    before_save :precompile!, unless: :precompiled?
  end
  
  def precompiled?
    Digest::MD5.hexdigest(raw) == fingerprint
  end
  
  def precompile!
    write_attribute :compiled, Precompiler.new(self, :blog, %w{ApplicationHelper Blog::ApplicationHelper}).precompile
    write_attribute :fingerprint, Digest::MD5.hexdigest(raw)
  rescue
    p "#{ self } can't precompile - error #{ $! }"
    write_attribute :compiled, raw
  end
end

