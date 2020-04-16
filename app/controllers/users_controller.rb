class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
    render "users/new"
  end
end
