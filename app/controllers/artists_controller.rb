class ArtistsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_artist, only: %i[show update destroy]

  def index
    authorize Artist
    @pagy, @artists = pagy(Artist.select("artists.*, (SELECT COUNT(*) FROM musics WHERE musics.artist_id = artists.id) AS music_count").order("artists.id ASC"))
    render json: @artists
  end

  def show
    authorize Artist
    if @artist
      music_count = @artist.music.count
      render json: @artist.as_json.merge({ music_count: music_count })
    else
      render json: { error: "Artist not found" }, status: :not_found
    end
    Pagy::DEFAULT[:overflow] = :empty_page    # default  (other options: :last_page and :exception)
  end

  def create
    @artist = Artist.new(artist_params)
    authorize Artist
    if @artist.save
      render json: @artist, status: :created
    else
      render json: @artist.errors, status: :unprocessable_entity
    end
  end

  def update
    authorize Artist
    if @artist.update(artist_params)
      render json: @artist
    else
      render json: @artist.errors, status: :unprocessable_entity
    end
  end

  def destroy
    authorize Artist
    @artist.destroy
    head :no_content
  end

  def import
    authorize Artist
    file = params[:file]

    if file.blank?
      render json: { error: "No file uploaded" }, status: :bad_request
      return
    end

    begin
      Artist.from_csv(file)
      render json: { message: "CSV imported successfully" }, status: :ok
    rescue => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end

  def export
    authorize Artist
    @artists = Artist.all
    send_data @artists.to_csv, filename: ["Artists", DateTime.now].join("_"), type: "text/csv; charset=utf-8; header=present"
  end

  private

  def set_artist
    @artist = Artist.find(params[:id])
  end

  def artist_params
    params.permit(:name, :dob, :gender, :address, :first_release_year, :no_of_albums_released)
  end
end
