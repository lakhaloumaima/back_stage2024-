require 'jwt'

class SessionsController < ApplicationController

  def create
    user = User.find_by(email: session_params[:email])

    if user&.authenticate(session_params[:password])
      token = encode_token(user_id: user.id, email: user.email)
      session[:user_id] = user.id

      render json: { status: :ok, token: token, user: user, subdomain: user.company.subdomain }
    else
      render json: { status: :unauthorized, error: 'Invalid email or password' }
    end
  end

  def destroy
    session[:user_id] = nil
    render json: { message: "Déconnexion réussie." }, status: :ok
  end

  private

  def session_params
    params.require(:user).permit(:email, :password)
  end

  def encode_token(payload)
    JWT.encode(payload, Rails.application.credentials.jwt_secret_key, 'HS256')
  end

end
