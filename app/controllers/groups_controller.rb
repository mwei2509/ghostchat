class GroupsController < ApplicationController
  before_action :set_group, only: [:authenticate, :edit, :update, :destroy]
  def new
    @group = Group.new
    respond_to do |format|
      format.html {render :new, locals: {group: @group, user: User.new}, :layout=>'layouts/formlayouts'}
    end
  end

  def create
    @group=Group.new(group_params)
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
      if @group.password_digest
        render :password, locals: {group: @group}, :layout=>'layouts/formlayouts'
      else
        render :makeusers, locals: {group: @group, user: User.new}, :layout=>'layouts/formlayouts'
      end
    end
  end

  def password
  end

  def edit
  end

  def update
    @group.set_expiration(group_params[:expiration])
    if @group.save
      redirect_to @group
    else
      flash[:error]=@group.errors.full_messages[0]
      redirect_to @group
    end
  end

  def destroy
    @group.destroy
  end

  def authenticate
    if @group && @group.authenticate(group_params[:password])
      render :makeusers, locals: {group: @group, user: User.new}, :layout=>'layouts/formlayouts'
    else
      flash[:error]="Wrong Password"
      render :password, locals: {group: @group}, :layout=>'layouts/formlayouts'
    end
  end
  private

  def set_group
    if params[:group_slug]
      @group=Group.find_by(slug: params[:group_slug])
    else
      @group = Group.find_by(slug: params[:slug])
    end
  end

  def group_params
    params.require(:group).permit(:title, :password, :expires_in)
  end
end
