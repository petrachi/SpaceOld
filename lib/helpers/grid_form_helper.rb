module GridFormHelper
  
  def merge_form_tag
=begin
    passer inputs
    permettre de passer un block pour personnaliser le form
    passer un objet pour les valeurs par défault
    passer l'url pour validation
    
    init les qtips + le js merge for
=end    
  end
  
  def form_row field_name, options = Hash.new, &block
    html_id, html_class, label, qtip, default, placeholder, errors = options.delete_many :id, :class, :label, :qtip, :default, :placeholder, :errors
    
    
    label ||= t("forms.labels.#{ field_name }", :raise => I18n::MissingTranslationData) rescue nil unless label == false
    qtip ||= t("forms.qtips.#{ field_name }", :raise => I18n::MissingTranslationData) rescue nil unless qtip == false    
    placeholder ||= t("forms.placeholders.#{ field_name }", :raise => I18n::MissingTranslationData) rescue nil unless placeholder == false
    
    
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
  
  
  
end
