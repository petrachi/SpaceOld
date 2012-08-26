module Game::AssociateJoin
  
  module ClassMethods
    def has_many_for_ternary focus_class, join_table, associations
      focus_class.class_eval "has_many :#{ join_table }, :dependent=>:destroy"
      associations.each do |association|
        focus_class.class_eval "has_many :#{ association.pluralize }, :through=>:#{ join_table }"
      end
    end
    
    def associate
      eval "@join_table = #{ name.demodulize }Join"
      [:user, :province, name.demodulize.underscore].each do |attr|
        @join_table.class_eval "belongs_to :#{ attr }"
      end
      
      demodulized_join = @join_table.name.demodulize.underscore.pluralize
      
      has_many_for_ternary self, demodulized_join, ["user", "province"]
      has_many_for_ternary Game::Province, demodulized_join, ["user", name.demodulize.underscore]
      has_many_for_ternary Game::User, demodulized_join, [name.demodulize.underscore, "province"]
    end
  end
  
  def self.included(base)
    base.extend(ClassMethods)
    base.associate
  end
  
end

