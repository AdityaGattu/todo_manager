class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def index
    render plain: User.all.map { |user| user.to_displayable_string }.join("\n")
  end

  def new
   # render "users/new"
  end

  def create
    user = User.new_user(params)
    if user.save
      session[:current_user_id] = user.id
      flash[:success] = "Signed up sucessfully! You are logged in automatically"
      redirect_to "/"
    else
      flash[:error] = user.errors.full_messages.join(", ")
      redirect_to new_user_path
    end
  end

  def check
    render plain: User.check(params)
  end

end
