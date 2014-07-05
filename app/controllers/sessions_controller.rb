class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"])
    if user.nil?
      user = User.create_with_omniauth(auth)
      redirect_path = root_path
    else
      # redirect_path = user_path(user.id)
      redirect_path = root_path
    end
    session[:user_id] = user.id
    redirect_to redirect_path, :notice => "Signed in!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end

end
