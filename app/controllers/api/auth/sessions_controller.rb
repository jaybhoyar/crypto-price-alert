class Api::Auth::SessionsController < ApplicationController

  def login
    @user = User.find_by_email(params[:user][:email])
    if @user&.authenticate(params[:user][:password])
      token = JsonWebToken.encode(user_id: @user.id)
      render json: { token: token, user: @user }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end
end
