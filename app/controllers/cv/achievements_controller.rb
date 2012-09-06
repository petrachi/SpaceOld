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
  
  def destroy
    if Achievement.where(:id => params[:id], :user_id => current_user.id).first.try(:destroy).present?
      flash[:notice] = "achievement supprime"
    else
      flash[:alert] = "Impossible de supprimer cet element"
    end
    
    redirect_to :action=>:index
  end
end
