class GossipsController < ApplicationController
  before_action :authenticate_user, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  before_action :is_user, only: [:edit, :update, :destroy]

  def index
    @gossips2 = Gossip.all
  end

  def show
    id = params[:id]
    @gossipsfind = Gossip.find(params[:id])
    @user = User.find(params[:id])
    @comments = @gossipsfind.comments
    @comment = Comment.new
  end

  def new
    @gossip = Gossip.new
    @tag = Tag.all
  end

  def create
    @gossip = Gossip.create("title" => params[:title],
                            "content" => params[:content],
                            "user_id" => session[:user_id])
    if @gossip.save
      flash[:notice] = "Good"
      redirect_to gossip_path(@gossip.id)
    else
      flash[:notice] = "Not good"
      render "new"
    end
  end

  def edit
    @gossip_edit = Gossip.find(params[:id])
  end

  def update
    @gossip = Gossip.find(params[:id])
    post_params = params.require(:gossip).permit(:title, :content)
    @gossip.update(post_params)
    redirect_to gossip_path(@gossip.id)
  end

  def destroy
    @gossip = Gossip.find(params[:id])
    @gossip.destroy
    flash[:notice] = "Delete"
    redirect_to root_path
  end

  private

  def authenticate_user
    unless current_user
      flash[:danger] = "Please log in."
      redirect_to new_session_path
    end
  end

  def is_user
    @gossip = Gossip.find(params[:id])
    unless current_user.id == @gossip.user_id
      flash[:danger] = "Tu ne peux pas modifier cela."
      redirect_to root_path
    end
  end
end
