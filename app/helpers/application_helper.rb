module ApplicationHelper

  def current_user
    @current_user ||= User.find session[:user_id] if session[:user_id]
    if @current_user
      @current_user
    else
      #OpenStruct.new(name: 'Guest')
    end
  end
end
