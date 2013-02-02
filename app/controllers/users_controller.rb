class UsersController < ApplicationController
  load_and_authorize_resource

  def profile
    @user = current_user
  end
end
