class UsersController < ApplicationController
  before_filter :authenticate, except: :show

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @songs = Song.find_with_reputation(:votes, :all, {:conditions => ['user_id = ?', @user.id], order: "votes"}).sort_by(&:votes).reverse
    @songs = Kaminari.paginate_array(@songs).page(params[:page]).per(10)

    # @songs = Song.where(user_id: @user.id).page(params[:page]).per(10)
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    user.save
    redirect_to root_path
  end

  # def edit
  #   @user = current_user
  # end

  # def update
  #   @user = current_user

  #   if params[:user][:name].nil?
  #     params[:user].delete(:name)
  #   end

  #   @user.update(user_params)
  #   redirect_to user_path(params[:id])
  # end

  def destroy
    session[:user_id] = nil
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:name)
  end

end
