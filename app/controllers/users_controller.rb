class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
    render "users/new"
  end

  def create
    User.create!(
      firstname = params[:firstname],
      lastname = params[:lastname],
      email = params[:email],
      password = params[:password],
    )
    redirect_to "/"
  end
end
