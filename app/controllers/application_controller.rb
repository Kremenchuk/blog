class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception



  def user_login
    if $user_login != nil
      flash.now[:success] = "good"
    else
      flash.now[:error] = "Ошибка в заполнении формы"
    end
  end
end
