module GridHelper
  
  def grid element_class, options = Hash.new, &block
    html_id, html_class = options.delete_many :id, :class
    content_tag(:div, nil, :id => html_id, :class => "#{ element_class } #{ html_class }" , &block)
  end
  
  def col col_number, options = Hash.new, &block
    html_id, html_class, collection = options.delete_many :id, :class, :collection    
    collection ||= [1]
    
    span_width, collection_length = case col_number
    when "one" then [:twelve, 1]
    when "two" then [:six, 2]
    when "three" then [:four, 3]
    when "four" then [:three, 4]
    when "six" then [:two, 6]
    when "twelve" then [:one, 12]
    end
    
    raise ArgumentError, "collection.size must be <= #{ collection_length }" if collection.size > collection_length
    
    cols = collection.map do |elt|
      eval %{
        #{ span_width }_span do
          capture(elt, &block)
        end }
    end
        
    row :id => html_id, :class => html_class do
      cols.inject(ActiveSupport::SafeBuffer.new){ |buffer, col| buffer.safe_concat(col) }
    end
  end
  
  def recollect size, collection
    recollected = Array.new
    0.step(collection.size - 1, size) do |i|
      recollected << collection[i..i + size - 1]
    end
    recollected
  end
  
  def rows col_number, options = Hash.new, &block
    html_id, html_class, collection = options.delete_many :id, :class, :collection    
    collection ||= [1]
    
    recollection_size = {"one" => 1, "two" => 2, "three" => 3, "four" => 4, "six" => 6, "twelve" => 12}[col_number]
    
    rows = recollect(recollection_size, collection).map do |collection_mini|
      col col_number, {:collection => collection_mini}, &block
    end
    
    container :id => html_id, :class => html_class do
      rows.inject(ActiveSupport::SafeBuffer.new){ |buffer, col| buffer.safe_concat(col) }
    end
  end
  
  def dynamic_method method_name, *args, &block
    case method_name.to_s
    when /^(container|row|(one|two|three|four|five|six|seven|eight|nine|ten|eleven|twelve)_span)$/
      lambda{ self.grid($1, *args, &block) }
    when /^(one|two|three|four|six|twelve)_col_row$/
      lambda{ self.col($1, *args, &block) }
    when /^(one|two|three|four|six|twelve)_col_container$/
      lambda{ self.rows($1, *args, &block) }
    else super
    end
  end
  
  
  def form_row field_name, options = Hash.new, &block
    html_id, html_class, label, default, placeholder = options.delete_many :id, :class, :label, :default, :placeholder
    
    form_row = three_span do
      label_tag field_name, label
    end
    
    form_row += six_span do
        if block.present?
          capture(&block)
        else
          text_field_tag field_name, default, :placeholder=>placeholder
        end
    end
    
    form_row += three_span do
      content_tag(:span, nil, :class => "errors_for_#{ field_name }")
    end
    
    row :id => html_id, :class => html_class do form_row end
  end
  
  def js_merge_row options = Hash.new
    init, loading, errors, bug, save = options.delete_many :init, :loading, :errors, :bug, :save
    init ||= t("forms.merge_form.init")
    loading ||= t("forms.merge_form.loading")
    errors ||= t("forms.merge_form.errors")
    bug ||= t("forms.merge_form.bug")
    save ||= t("forms.merge_form.save")
    
    merge_button = content_tag :span, t("forms.send"), :class => "merge-button"
    
    content_tag :div, :id => "js-merge-form" do
      merge_rows = one_col_row :id => "merge-init" do
        (init + merge_button).html_safe
      end
      
      merge_rows += one_col_row :id => "merge-loading", :class => :hidden do
        (loading + merge_button).html_safe
      end
      
      merge_rows += one_col_row :id => "merge-errors", :class => :hidden do
        (errors + merge_button).html_safe
      end
      
      merge_rows += one_col_row :id => "merge-bug", :class => :hidden do
        (bug + merge_button).html_safe
      end
      
      merge_rows += one_col_row :id => "merge-save", :class => :hidden do
        (save + merge_button).html_safe
      end
    end  
  end
  
end
