class MusicsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_music, only: %i[show update destroy]

  def index
    if params[:artist_id].present?
      @pagy, @music = pagy(Music.where(artist_id: params[:artist_id]).order("id ASC"))
    else
      @pagy, @music = pagy(Music.all.order("id ASC"))
    end
    render json: @music
  end

  def show
    render json: @music
  end

  def create
    @music = Music.new(music_params)
    if @music.save
      render json: @music, status: :created
    else
      render json: @music.errors, status: :unprocessable_entity
    end
  end

  def update
    if @music.update(music_params)
      render json: @music
    else
      render json: @music.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @music.destroy
    head :no_content
  end

  private

  def set_music
    begin
      @music = Music.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      render json: {
        error: e.to_s
      }, status: :not_found
    end
  end

  def music_params
    params.permit(:artist_id, :title, :album_name, :genre)
  end
end
