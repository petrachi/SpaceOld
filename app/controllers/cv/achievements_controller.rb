class Cv::AchievementsController < Cv::ApplicationController
  before_filter :access_authorized?, :except => :show
  
  def index
  end
  
  def show
  end

  def edit
    edit_errors params.merge(:call=>"ruby")
    
    if @errors.blank?
      # add cv_user_id to params
      @achievement.update_attributes params.select_from_collection([:year, :activity, :brief])#.merge({:cv_user=>current_user})
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
    @achievement = Achievement.find_by_id(params[:id]) || Achievement.new
    
    @errors = {}
    
    if params[:call] == "js"
        render :text=>@errors.map{ |field, error| "#{ field } : #{ error }" }.join("<br/>")
    end
  end
  
  def destroy
    Achievement.find_by_id(params[:id]).destroy
  end
end
