class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to(session[:return_to_url] || root_path)
    else
      render 'new'
    end
  end

  # TODO: this is a very basic user authentication. If password updating or resetting, or
  #       other more advanced features are required (e.g. activation and activation emails,
  #       reset emails, etc.), then this approach should be replaced by something like
  #       Devise or Sorcery --- no need to reinvent the wheel. However, for the purposes of
  #       this exercise, this implementation should suffice.

private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
