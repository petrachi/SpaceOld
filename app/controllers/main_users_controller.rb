class MainUsersController < ApplicationController 
  
  action_form :sign_up, :model => MainUser,
              :validation => -> do
                session[:user_id] = @object.id
              end
  
  action_form :sign_in, 
              :errors => ->(params) do
                @errors = Array.new
                @user = MainUser.find_by_email params[:email]
                
                check_errors_for [:email, :password] do |attr|
                  params[attr].blank?
                end

                check_errors_for :email do
                  @user.blank?
                end

                check_errors_for :password do
                  @user.authenticate(params[:password]).blank?
                end
              end,
  
              :validation => -> do
                session[:user_id] = @user.id
              end,
              
              :safe_validation => -> do
                session[:user_id].present?
              end

  def sign_out
    session[:user_id] = nil
    redirect_to root_url(:subdomain => false), :notice => "Logged out"
  end
end
