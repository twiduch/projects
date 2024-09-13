class SessionsController < ApplicationController
  def create
    session[:user_id] = (params[:user_id].presence || 1)
  end
end
