class UsersController < ApplicationController
  def new
    @group=Group.find_by(slug: params[:group_slug])
    @user=User.new
  end

  def create
    @user=User.new(user_params)
    @group=Group.find_by(slug: params[:group_slug])
    @user.group = @group
    if @user.save
      session["group_#{@group.id}_user_id"]=@user.id
      redirect_to @group
    else
      redirect_to @group
    end
  end

  private
  def user_params
    params.require(:user).permit(:username)
  end
end
