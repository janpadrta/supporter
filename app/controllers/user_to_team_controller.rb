class UserToTeamController < ApplicationController
  before_action :leader_required!

  # PATCH/PUT /users/1
  def update
    @user = User.includes(:team).find(params[:user][:id])

    if @user.update(user_params)
      redirect_to team_url(@user.team), notice: "User #{@user.name} has been added."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.includes(:team).find(params[:user_id])
    team = @user.team

    @user.update_attribute(:team_id, nil)
    
    redirect_to team_url(team), notice: "User #{@user.name} has been removed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.includes(:team).find(params[:user][:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:team_id)
  end
end
