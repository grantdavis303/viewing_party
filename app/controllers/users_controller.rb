class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    if current_user
      @user = User.find(params[:id])
    else
      flash[:message] = "You must be logged in or registered to access a user's dashboard"
      redirect_to "/"
    end
  end

  def create
    user = User.create(user_params)
    session[:user_id] = user.id
    if user.save
      flash[:success] = 'Successfully Created New User'
      redirect_to user_path(user)
    else
      flash[:error] = "#{error_message(user.errors)}"
      redirect_to register_user_path
    end   
  end

  def login_form
  end

  def login_user
    cookies[:location] = {value: params[:location], expires: 1.day}
    user = User.find_by(email: params[:email])
    session[:user_id] = user.id   
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}!"
      redirect_to "/users/#{user.id}"
    else
      flash[:error] = "Sorry, your credentials are bad."
      render :login_form
    end
  end

  def logout_user
    #binding.pry
    session.destroy
    redirect_to "/"
  end

  private def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end