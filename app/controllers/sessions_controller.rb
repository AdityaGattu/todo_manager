class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find(email: params[:email])
    if user.authenticate(params[:password])
      render plain: "correct password"
    else
      render plain: "incorrect password"
    end
  end
end
