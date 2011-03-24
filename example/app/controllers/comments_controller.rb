class CommentsController < ApplicationController
  before_filter
  
  
  def index
    @comments = Comment.all
  end
  
  def new
    @comment = Comment.new
  end
  
  def create
    @comment = Comment.new(params[:comment])
    if @comment.save
      redirect_to :action => "index"
    else
      render :new
    end
  end
  
  def edit
    @comment = Comment.find(params[:id])
  end
  
  def update
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(params[:comment])
      redirect_to :action => :index
    else
      render :edit
    end
  end
  
  def destroy
    
  end
  
end
