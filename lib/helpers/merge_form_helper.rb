module MergeFormHelper
  module ClassMethods
    def merge_form method_name, class_name, options = Hash.new, &block
      # options => errors perso, valid persos
      
      
      
      define_method method_name do

        object_name = "@#{ class_name.name.demodulize.underscore }"
        
        instance_variable_set object_name, class_name.new( params ) )
        

      end
      
      
      ActiveRecord::Base.transaction do
        raise ActiveRecord::Rollback
      end
      
      def sign_up
        sign_up_errors params.merge(:call=>"ruby")

        if @user.errors.blank?
          @user.save
        end

        if params[:call] == "js"
          if @user.id.present?
            @valid, flash[:notice] = true, "Signed in"
            respond_to do |format|        
              format.js
            end
          elsif @user.errors.present?
            render :json => @user.errors.keys
          else
            render :text => "bug-merge"
          end
        else
          respond_to do |format|        
            format.js
          end
        end
      end

      def sign_up_errors params = params
        @user = MainUser.new params.select_from_collection([:first_name, :name, :email, :password, :password_confirmation])
        @user.valid?

        if params[:call] == "js"
            render :json => @user.errors.keys
        end
      end
      
      
      include MergeFormHelper
      merge_form


      
      
      
      
    end
  end
  
  def self.included(base)
    base.extend(ClassMethods)
  end
end