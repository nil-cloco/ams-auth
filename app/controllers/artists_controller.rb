class ArtistsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_artist, only: %i[show update destroy]
  
    def index
      @artists = Artist.select("artists.*, (SELECT COUNT(*) FROM musics WHERE musics.artist_id = artists.id) AS music_count")
      render json: @artists
    end
  
    def show
      if @artist
        music_count = @artist.music.count
        render json: @artist.as_json.merge({ music_count: music_count })
      else
        render json: { error: "Artist not found" }, status: :not_found
      end
    end
  
    def create
      @artist = Artist.new(artist_params)
      if @artist.save
        render json: @artist, status: :created
      else
        render json: @artist.errors, status: :unprocessable_entity
      end
    end
  
    def update
      if @artist.update(artist_params)
        render json: @artist
      else
        render json: @artist.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @artist.destroy
      head :no_content
    end
  
    private
  
    def set_artist
      @artist = Artist.find(params[:id])
    end
  
    def artist_params
      params.permit(:name, :dob, :gender, :address, :first_release_year, :no_of_albums_released)
    end
  end