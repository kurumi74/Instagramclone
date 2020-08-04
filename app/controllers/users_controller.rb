class UsersController < ApplicationController
  before_action :login_check, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id), notice: "アカウントを作成しました。ログインしてください"
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to edit_user_path, notice: "編集が完了しました"
    else
      render 'edit'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :image)
  end

  def login_check
    @user = User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to new_user_path
    end
  end
end
