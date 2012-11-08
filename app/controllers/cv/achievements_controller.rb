class Cv::AchievementsController < Cv::ApplicationController
  before_filter :access_authorized?, :except => :show
  
  def index
    @achievements = current_user.achievements
  end
  
  def show
    @user = User.where(:id=>params[:id]).first
    if @user.present?
      @achievements = @user.achievements
    end
  end




  include MergeFormHelper
  merge_form  :edit, Achievement, 
              :edit => ->(params) do
                  #current_user is not a method of controler => why is it call like a self.method, instead of like in a def; curren_user; end
                  # if i puts current_user in merge module, it puts right
                  #p method(:current_user)
                  
                  
                  {:id => params[:id], :user_id => UsersController.new.current(@_request).id}
                end
  
  
  
  
  
            
=begin
  def edit
    edit_errors params.merge(:call=>"ruby")
    
    if @errors.blank?
      @achievement.update_attributes params.select_from_collection([:year, :activity, :brief]).merge({:user=>current_user})
    end
    
    if params[:call] == "js"
      if @achievement.valid?
        flash[:notice] = "achievement ajoute au profil"
        render :text => "valid-merge"        
      elsif @errors.present?
        render :json => @errors
      else
        render :text => "bug-merge"
      end
    end
  end
  
  def edit_errors params = params
    @errors = Array.new
    @achievement = Achievement.where(:id => params[:id], :user_id => current_user.id).first || Achievement.new
    
    # passer les validations dans le modele et imiter sing_up.
    # s possible, creer un helper de méthodes de validations (à appeller dans la class, like "helper_method" ou "before_filter", qui créerait l'action d'erreurs,avec un block optionnel pour les erreurs (qui sont hors modeles), et un proc? pour récupérer l'objet)
    
    check_errors_for [:year, :activity, :brief] do |attr|
      params[attr].blank?
    end
    
    check_errors_for :year do
      params[:year] != params[:year].to_i.to_s
    end
    
    if params[:call] == "js"
      render :json => @errors
    end
  end
=end  
  def destroy
    if Achievement.where(:id => params[:id], :user_id => current_user.id).first.try(:destroy).present?
      flash[:notice] = "achievement supprime"
    else
      flash[:alert] = "Impossible de supprimer cet element"
    end
    
    redirect_to :action=>:index
  end
end