class ApplicationController < ActionController::Base
	helper_method :current_user, :authenticate_user!

	before_action :authenticate_user!
  before_action :zapis_uzivatele_do_logu

  def current_user
    # If session[:user_id] is nil, set it to nil, otherwise find the user by id.
    #@current_user ||= session[:user_id] && User.find_by(id: session[:user_id])

    @current_user ||= session[:current_active_session_id] && ActiveSession.find_by(id: session[:current_active_session_id]).user
  end

  def authenticate_user!
    redirect_to new_user_session_path, alert: "You need to login to access that page." unless current_user
  end

  def admin_required!
    redirect_to :root, alert: "You have no access here..." unless current_user.admin?
  end

  def leader_required!
    redirect_to :root, alert: "You have no access here..." unless current_user.is_leader?
  end

  def zapis_uzivatele_do_logu
    string = "\n-----------------------------------------------------\n"
    string += "V #{Time.zone.now.strftime('%d.%m.%Y %H:%M:%S')} provadi uzivatel #{current_user.blank? ? 'neprihlasen' : current_user.name} (#{request.env['REMOTE_HOST']}) "
    string += "akci kontroleru = #{params[:controller]}::#{params[:action]} "
    string += "s ID=#{params[:id]} " if params[:id]
    string += "s params: #{params}" if params
    string += "\n-----------------------------------------------------\n "
    logger.info(string)
  end
end
