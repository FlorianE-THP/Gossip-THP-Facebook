class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      log_in(user)
      if params[:remember_me]
        remember(user)
        redirect_to root_path
      else
        remember_temp(user)
        redirect_to root_path
      end
    else
      flash.now[:danger] = "Invalid email/password combination"
      render "new"
    end
  end

  def destroy
    user = User.find_by(email: params[:email])
    session.delete(:user_id)
    log_out(user)
    redirect_to root_path
  end
end
