module MergeFormHelper
  module ClassMethods
    # U must can create / edit on the same method, by passing the id of the object
    # this render the action via http (like achievments), add option to init these actions base on a js render (like sign_up)
    def merge_form method_name, object_class, options = Hash.new, &block
      
      # U must can choose the object name
      object_name = "@#{ object_class.name.demodulize.underscore }"
      
      
      
      error_method_name = "#{ method_name }_errors"
      
      
      # add your specific saves things (ex : create fake stats when create lms_ent)
      define_method method_name do
        if eval("#{ error_method_name } params.merge(:call=>\"ruby\")").blank?
          @object.save
        end
        
        instance_variable_set object_name, @object
        
        p object_name
        
        if params[:call] == "js"
          if @object.id.present?
            flash[:notice] = "youpi"
            render :text => "valid-merge"
          elsif @user.errors.present?
            render :json => @object.errors.keys
          else
            render :text => "bug-merge"
          end
        end
      end
      
      # select from coll must be all fields from table, or pass in params
      # U must can add specific values to params (ex user id)
      # add your specific validateions
      define_method error_method_name, ->(params = params, &block) do
        
        
        @object = object_class.new(params.select_from_collection([:year, :activity, :brief]))
        @object.valid?
        
        if params[:call] == "js"
          render :json => @object.errors.keys
        elsif params[:call] == "ruby"
          return @object.errors.keys
        end
      end
      
      
      
      
=begin
      
      
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


=end      
      
      
      
    end
  end
  
  def self.included(base)
    base.extend(ClassMethods)
  end
end