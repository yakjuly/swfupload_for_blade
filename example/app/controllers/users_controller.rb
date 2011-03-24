class UsersController < ApplicationController
  before_filter :prepare_user
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    
    if @user.save
      redirect_to :action => :index
    else
      render :new
    end
  end
  
  def edit
    
  end
  
  def update
    if @user.update_attributes(params[:user])
      redirect_to :action => :index
      
    else
      render :edit
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
