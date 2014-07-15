require "soundcloud"

class SongsController < ApplicationController
  # before_filter :authenticate

  def index
    @songs = Song.find_with_reputation(:votes, :all, order: "votes").sort_by(&:votes).reverse
    @songs = Kaminari.paginate_array(@songs).page(params[:page]).per(10)
  end

  def show
    @song = Song.find(params[:id])
  end

  def new
    @song = current_user.songs.new
  end

  def create
    song = current_user.songs.new(song_params)
    if (params[:song][:url] =~ /soundcloud{1}/i)
      song.save
      redirect_to root_path
    else
      redirect_to new_song_path
    end
  end

  # def edit
  #   @song = current_user.url
  # end

  # def update
  #   @song = Song.find(params[:id])

    #   @song.update(song_params)
    #   redirect_to user_path[:id]
    #   params[:song].delete(:url)
    # end

    # if params[:song][:url].blank?
    #   flash[:error] = "Please enter a URL"
    # end

  # end

  def destroy
    @song = Song.find(params[:id])
    @song.delete_evaluation(:votes, current_user)
    @song.destroy
    redirect_to user_path(current_user.id)
  end

  def vote
    value = params[:type] == "like" ? 1 : -1
    @song = Song.find(params[:id])
    @song.add_or_update_evaluation(:votes, value, current_user)
    respond_to do |format|
      format.json do
        render :json => {
          :status => :ok,
          :message => "Success!",
          :votes => @song.reputation_for(:votes).to_i
        }.to_json
      end
    end
  end

  private
  def song_params
    params.require(:song).permit(:url, :user_id)
  end
end
