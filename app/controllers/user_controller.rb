class UserController < ApplicationController
  def show
    id = params[:id]
    @userfind = User.find(params[:id])
    @comments = Gossip.where(user: @userfind)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], description: params[:description], city_id: 01, age: params[:age], password: params[:password])
    if @user.save
      log_in(@user)
      redirect_to root_path
    else
      flash[:notice] = "Not good"
      render "new"
    end
  end
end
