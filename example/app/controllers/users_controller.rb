class UsersController < ApplicationController
  before_filter :prepare_user
  
  def new
    render :edit
  end
  
  def update
    if @user.update_attributes(params[:user])
      render :edit
    else
      redirect_to :action => :index
    end
  end
  
  def destroy
    @user.destroy
    redirect_to :action => :index
  end
  
  private
  
  def prepare_user
    case action_name
    when "index"
      @users = User.all
    when "new"
      @user = User.create
    when "update", "edit", "destroy"
      @user = User.find(params[:id])
    end
  end
end
