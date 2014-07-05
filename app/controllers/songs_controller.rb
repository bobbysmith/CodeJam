class SongsController < ApplicationController
  before_filter :authenticate

  def index
    @songs = Song.all
  end

  def show
    @song = Song.find(params[:id])
  end

  def new
    @song = current_user.songs.new
  end

  def create
    song = current_user.songs.new(song_params)
    song.save
    redirect_to root_path
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    if params[:song][:url].blank?
      flash[:error] = "Please enter a URL"
      # params[:song].delete(:song)
    end

    @song.update(song_params)
    redirect_to user_path[:id]
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    redirect_to root_path
  end

  private
  def song_params
    params.require(:song).permit(:url, :user_id)
  end
end
