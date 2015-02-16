module PianobarNotify
  class Stations
    def capture
      File.open(STATIONS_FILE, "w") do |file|
        blob.stations.each_with_index do |station, i|
          file.puts "#{i}. #{station}#{current(station)}"
        end
      end
    end

    private

      STATIONS_FILE = "/tmp/pianobar_stations".freeze

      def current(station)
        " [playing]" if station == blob.station_name
      end

      def blob
        @blob ||= Blob.instance
      end
  end
end
