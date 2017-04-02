class UsersController < ApplicationController
  def new
    @group=Group.find_by(slug: params[:group_slug])
    @user=User.new
  end

  def create
    @group=Group.find_by(slug: params[:group_slug])
    if @group.password_digest
      authenticate = @group.authenticate(user_params[:group_password])
    else
      authenticate = true
    end
    if !user_params[:password].empty? && authenticate
      #validate creator
      @creator=User.find_by(username: user_params[:username], group_id: @group.id)
      if @creator && @creator.authenticate(user_params[:password])
        session["group_#{@group.id}_user_id"]=@creator.id
        redirect_to @group
      else
        flash[:error]="bad authentication"
        @user=User.new
        render :new
      end
    elsif authenticate
      #create user
      @user=User.new(username: user_params[:username])
      @user.group = @group
      if @user.save
        session["group_#{@group.id}_user_id"]=@user.id
        redirect_to @group
      else
        flash[:error]=@user.errors.full_messages[0]
        @user=User.new
        render :new
      end
    else
      flash[:error]="bad password"
      @user=User.new
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :group_password, :password)
  end
end
