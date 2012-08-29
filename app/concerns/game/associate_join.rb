module Game::AssociateJoin
  
  module ClassMethods
    def has_many_for_ternary focus_class, join_table, associations
      focus_class.class_eval "has_many :#{ join_table.demodulize.underscore.pluralize }, :dependent=>:destroy, :class_name => \"#{ join_table }\""
      associations.each do |association|
        focus_class.class_eval "has_many :#{ association.pluralize }, :through=>:#{ join_table.demodulize.underscore.pluralize }"
      end
    end
    
    def associate
      eval "@join_table = #{ self.name }Join"
      ["Game::User", "Game::Province", self.name].each do |belongs_table|
        @join_table.class_eval "belongs_to :#{ belongs_table.demodulize.underscore } #, :class_name => \"#{ belongs_table }\""
      end
            
      has_many_for_ternary self, @join_table.name, ["user", "province"]
      has_many_for_ternary Game::Province, @join_table.name, ["user", name.demodulize.underscore]
      has_many_for_ternary Game::User, @join_table.name, [name.demodulize.underscore, "province"]
      
      @join_table.class_eval "include AssociateNamespace; accessors_for_namespace :game"
    end
  end
  
  def self.included(base)
    base.extend(ClassMethods)
    base.associate
  end
  
end

