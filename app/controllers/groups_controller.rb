class GroupsController < ApplicationController

  def new
    @group = Group.new
    respond_to do |format|
      format.html {render :new, locals: {group: @group, user: User.new}, :layout=>'layouts/formlayouts'}
    end
  end

  def create
    @group=Group.new(group_params)
    byebug
    if @group.save

      respond_to do |format|
        format.html {render :makeusers, locals: {group: @group, user: User.new}, :layout=>false}
      end
    else
      render plain: "done goofed", status: 400
    end
  end

  def makeusers
  end

  def show
    @group = Group.includes(:messages).find_by(slug: params[:slug])
    @message = Message.new
    if Time.strptime(@group.expiration.to_s, '%s') < Time.now
      render plain: "expired"
    elsif !logged_in?(@group)
      respond_to do |format|
        format.html {render :makeusers, locals: {group: @group, user: User.new}, :layout=>'layouts/formlayouts'}
      end
    end
  end

  def edit
    @group = Group.find_by(slug: params[:slug])
  end

  def update
    @group = Group.find_by(slug: params[:slug])
    @group.set_expiration(group_params[:expiration])
    if @group.save
      redirect_to @group
    else
      flash[:error]=@group.errors.full_messages[0]
      redirect_to @group
    end
  end

  def destroy
    @group = Group.find_by(slug: params[:slug])
    @group.destroy
  end

  private

  def group_params
    params.require(:group).permit(:title, :password, :expires_in)
  end
end
