module Blog::Precompilable
  extend ActiveSupport::Concern
  
  included do
    before_save :precompile!, unless: :precompiled?
  end
  
  def md5
    Digest::MD5.hexdigest(raw)
  end
  
  def precompiled?
    md5 == fingerprint
  end
  
  def precompile!
    write_attribute :compiled, Precompiler.new(self, :blog, %w{ApplicationHelper Blog::ApplicationHelper}).precompile
    write_attribute :fingerprint, md5
  rescue
    p "#{ self } can't precompile - error #{ $! }"
    write_attribute :compiled, raw
  end
end
