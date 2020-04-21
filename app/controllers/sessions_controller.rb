class SessionsController < ApplicationController
  skip_before_action :ensure_user_logged_in
  def new
  end

  def create
    user = User.find(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:current_user_id] = user.id
      redirect_to "/"
    else
      flash[:error] = "Your login attempt is invalid"
      redirect_to new_sessions_path
    end
  end
end
