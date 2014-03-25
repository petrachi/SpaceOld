module Runnable
  extend ActiveSupport::Concern

  included do
    has_one :snippet, as: :runnable
    delegate :run, to: :snippet

    validates_presence_of :snippet
  end
end
