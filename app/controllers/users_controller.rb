class UsersController < ApplicationController
  def new
    @group=Group.find_by(slug: params[:group_slug])
    @user=User.new
  end

  def create
    @group=Group.find_by(slug: params[:group_slug])
    @user=User.new(user_params)
    @user.group = @group
    if @user.save
      session["group_#{@group.id}_user_id"]=@user.id
      redirect_to @group
    else
      respond_to do |format|
        format.html {render 'groups/makesers', locals: {group: @group, user: User.new}, :layout=>'layouts/formlayouts'}
      end
    end
  end

  private
  def user_params
    params.require(:user).permit(:username)
  end
end
