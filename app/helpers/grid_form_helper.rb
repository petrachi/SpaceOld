module GridFormHelper
  
  def form_row field_name, options = Hash.new, &block
    html_id, html_class, label, qtip, default, placeholder, errors = options.delete_many :id, :class, :label, :qtip, :default, :placeholder, :errors
    
    form_row = three_span do
      label_tag field_name, label, :class=>"#{ "qtip" if qtip }", :title=>qtip
    end
    
    form_row += six_span do
        if block.present?
          capture(&block)
        else
          text_field_tag field_name, default, :placeholder=>placeholder
        end
    end
    
    
    if errors != false
      errors ||= [:blank]
      errors = "<ul><li>" << errors.map{ |err| t("forms.errors.#{ err }").capitalize }.join("</li><li>") << "</li></ul>"
  
      form_row += three_span do
        content_tag(:span, "!", :class => "errors #{ "qtip" if errors }", :title => errors)
      end
    end
    
    row :id => html_id, :class => "#{ field_name } #{ html_class }" do form_row end
  end
  
  def js_merge_row options = Hash.new
    init, loading, errors, validate, bug, save = options.delete_many :init, :loading, :errors, :validate, :bug, :save
    init ||= t("forms.merge_form.init")
    loading ||= t("forms.merge_form.loading")
    errors ||= t("forms.merge_form.errors")
    validate ||= t("forms.merge_form.validate")
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
      
      merge_rows += one_col_row :id => "merge-validate", :class => :hidden do
        (validate + merge_button).html_safe
      end
      
      merge_rows += one_col_row :id => "merge-bug", :class => :hidden do
        (bug + merge_button).html_safe
      end
      
      merge_rows += one_col_row :id => "merge-save", :class => :hidden do
        (save + merge_button).html_safe
      end
    end  
  end
  
  
  def check_errors_for attr, no_blank = false, &block
    raise ArgumentError, "errors must be an Array" if @errors.class != Array
    
    case attr
    when String, Symbol
      unless @errors.include? attr
        @errors << attr if case block.arity
        when 0 then yield
        when 1 then yield(attr)
        else raise NotImplementedError, "block arity can be nil or 1"
        end
      end
      
    when Array
      attr.each do |single_attr|
        check_errors_for single_attr, &block
      end
      
    else
      raise ArgumentError, "attr must be a String, a Symbol or an Array"
    end
  end
end
