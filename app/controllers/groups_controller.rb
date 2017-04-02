class GroupsController < ApplicationController
  def new
    @group = Group.new
    @group.creator = User.new
  end

  def create
    @group=Group.new(group_params)
    if @group.save
      session["group_#{@group.id}_user_id"]=@group.creator.id
      redirect_to @group
    else
      @group=Group.new
      @group.creator=User.new
      render :new
    end
  end

  def show
    @group = Group.includes(:messages).find_by(slug: params[:slug])
    @message = Message.new
    if !logged_in?(@group)
      redirect_to new_group_user_path(@group)
    end
  end

  def edit
    @group = Group.find_by(slug: params[:slug])
  end

  def update
    @group = Group.find_by(slug: params[:slug])
    @group.update(group_params)
    if @group.save
      redirect_to @group
    else
      render :edit
    end
  end

  def destroy
    @group = Group.find_by(slug: params[:slug])
    @group.destroy
  end

  private
  def group_params
    params.require(:group).permit(:title, :password, :expiration,
      creator_attributes: [:username])
  end
end
