class UserToTeamController < ApplicationController
  before_action :set_user, only: %i[ update destroy ]
  before_action :leader_required!

  # PATCH/PUT /users/1
  def update
    p "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
    if @user.update(user_params)
      redirect_to team_url(@user), notice: "Team was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.includes(:team).find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:id, :team_id)
  end
end
