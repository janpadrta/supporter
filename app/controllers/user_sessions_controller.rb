class UserSessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]
  
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(name: params[:user][:name])

    if @user && @user.authenticate(params[:user][:password])
      reset_session
      active_session = @user.active_sessions.create!(user_agent: request.user_agent, ip_address: request.ip)
      session[:current_active_session_id] = active_session.id
      redirect_to root_path
    else
      flash[:alert] = "Login failed"
      redirect_to new_user_session_path
    end
  end

  def destroy
    active_session = ActiveSession.find_by(id: session[:current_active_session_id])
    reset_session
    active_session.destroy! if active_session.present?

    #session[:user_id] = nil
    redirect_to root_path
  end
end
