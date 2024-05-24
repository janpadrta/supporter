class UsersController < ApplicationController
  before_action :admin_required!
  
  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).includes(:team)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "User created successfully"
      redirect_to users_path
    else
      flash[:alert] = "User not created"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation, :admin, :technical, :team_leader, :approver, :team_id)
  end
end
