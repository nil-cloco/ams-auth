module ArtistCsvImportExport
  extend ActiveSupport::Concern
  require 'csv'

  class_methods do
    def to_csv
      attributes = %w{name dob gender address first_release_year no_of_albums_released}

      CSV.generate(headers: true) do |csv|
        csv << attributes
        all.each do |artist|
            csv << attributes.map{ |attr| artist.send(attr) }
        end
      end
    end

    def from_csv(file)
      CSV.foreach(file.path, headers: true) do |row|
        row_data = row.to_hash
        artist = Artist.new
        artist.update!(row_data)
      end
    end
  end
end
  