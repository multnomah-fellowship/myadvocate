# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: session_params[:email]).try(:authenticate, session_params[:password])

    unless user
      flash[:error] = 'Incorrect email or password'
      return redirect_to new_sessions_path
    end

    session[:user_id] = user.id

    redirect_to root_path
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path
  end

  private

  def session_params
    params.fetch(:session, {}).permit(:email, :password)
  end
end
