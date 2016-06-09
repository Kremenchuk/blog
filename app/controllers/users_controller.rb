class UsersController < ApplicationController

  def index
    #$user_login = nil
  end

  def show
    @email      = String(params[:email])
    @password   = String(params[:password_user])
    @user = User.find_by(email: @email)

    if @user != nil
      if BCrypt::Password.new(@user.password_digest).is_password?(@password)
        $user_login = @user
        redirect_to "/posts"
      else
        redirect_to action: "index"
      end
    else
      redirect_to action: "new"
    end
  end

  def new
    @user = User.new
  end

  def create

    uploaded_io = params[:user][:avatar]
    if uploaded_io != nil
      File.open(Rails.root.join('public', uploaded_io.original_filename), 'wb') do |file|
        file.write(uploaded_io.read)
      end
    end

    if params[:user][:name] !="" and params[:user][:email] != "" and params[:user][:password] != ""
      if @user = User.where(email: params[:user][:email]).first == nil
        @user = User.create!(params[:user])
        if uploaded_io != nil
          @user.update_attributes(avatar: "#{uploaded_io.original_filename}")
        else
          @user.update_attributes(avatar: "")
        end
        @user.save!
        $user_login = @user

        if @user.errors.empty?
          redirect_to "/posts"
        else
          flash[:error]="invalid data"
          redirect_to "/users/new"
        end

      else
        flash[:error]="Email has already been taken"
        redirect_to "/users/new"
      end

    else
      flash[:error]="invalid data"
      redirect_to "/users/new"
    end

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
      uploaded_io = params[:user][:avatar]
      File.open(Rails.root.join('public', uploaded_io.original_filename), 'wb') do |file|
        file.write(uploaded_io.read)
      end


    @user = User.find(params[:id])
    @user.update_attributes(avatar: "#{params[:user][:avatar]}")
    redirect_to "/posts"
  end

end
