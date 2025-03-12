class MusicsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_music, only: %i[show update destroy]
  
    def index
      if params[:artist_id].present?
        @music = Music.where(artist_id: params[:artist_id])
      else
        @music = Music.all
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
      @music = Music.find(params[:id])
    end
  
    def music_params
      params.permit(:artist_id, :title, :album_name, :genre)
    end
  end
  