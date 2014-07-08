require "soundcloud"

class SongsController < ApplicationController
  # before_filter :authenticate

  def index
    @songs = Song.find_with_reputation(:votes, :all, order: "votes")
    @songs = @songs.sort_by(&:votes).reverse
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
    @song = current_user.url
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

  def vote
    value = params[:type] == "like" ? 1 : -1
    @song = Song.find(params[:id])
    @song.add_or_update_evaluation(:votes, value, current_user)
    # respond_to do |format|
    #   format.json do
    #     render :json => {
    #       :status => :ok,
    #       :message => "Success!",
    #       :votes => @song.reputation_for(:votes).to_i
    #     }.to_json
    #   end
    # end
      redirect_to :back
  end

  private
  def song_params
    params.require(:song).permit(:url, :user_id)
  end
end
