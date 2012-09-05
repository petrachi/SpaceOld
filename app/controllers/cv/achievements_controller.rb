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
        flash[:notice] = "Signed in"
        redirect_to :action=>:index
      elsif @errors.present?
        render :text=>@errors.map{ |field, error| "#{ field } : #{ error }" }.join("<br/>")
      else
        render :text => "bug-merge"
      end
    end
  end
  
  def edit_errors params = params
    @achievement = Achievement.where(:id => params[:id], :user_id => current_user.id).first || Achievement.new
    
    @errors = {:year => "ne peut pas etre vide"} if params[:year].blank?
    @errors ||= {}
    
    if params[:call] == "js"
        render :text=>@errors.map{ |field, error| "#{ field } : #{ error }" }.join("<br/>")
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
