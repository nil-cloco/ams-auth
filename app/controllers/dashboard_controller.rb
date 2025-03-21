class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    history_days = params[:days].present? ? Integer(params[:days]) : 30
    total_counts = {
      users: User.count,
      artists: Artist.count,
      musics: Music.count
    }

    # Define the date range (last 30 days)
    start_date = history_days.days.ago.beginning_of_day
    end_date = Time.current.end_of_day

    # Fetch counts in a single query for each model
    user_counts = User.where(created_at: start_date..end_date)
                      .group("DATE(created_at)")
                      .count

    artist_counts = Artist.where(created_at: start_date..end_date)
                          .group("DATE(created_at)")
                          .count

    music_counts = Music.where(created_at: start_date..end_date)
                        .group("DATE(created_at)")
                        .count

    # Prepare daily data for the last 30 days
    daily_counts = (0..(history_days-1)).map do |i|
      date = i.days.ago.to_date
      {
        date: date.strftime('%d/%m/%Y'),
        users: user_counts[date] || 0,
        artists: artist_counts[date] || 0,
        musics: music_counts[date] || 0
      }
    end.reverse  # Reverse to display in ascending order

    # Render JSON response
    render json: {
      count: total_counts,
      daily_count: daily_counts
    }
  end

end
