class UsersController < ApplicationController
  before_filter :authenticate_user!

  before_filter do 
    redirect_to new_user_session_path unless current_user.admin?
  end


  def index
    if current_user.admin?
      @users = User.all
      @users_accounts = Account.all
      @users_transactions = Transaction.all
      @users_documents = Document.all

      @visits = Visit.all
    end
  end


  def show
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to :back, :alert => "Access denied."
    end
  end

end

