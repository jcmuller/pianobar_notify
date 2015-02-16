module PianobarNotify
  class CLI
    def self.run
      new.call
    end

    def call
      notification.call if show_notification?
      stations.capture  if capture_stations?
    end

    private

      def show_notification?
        %w(songexplain songstart songlove songban).include?(blob.action)
      end

      def capture_stations?
        %w(songstart).include?(blob.action)
      end

      def blob
        @blob ||= Blob.instance
      end

      def notification
        @notification ||= Notification.new
      end

      def stations
        @station ||= Stations.new
      end
  end
end
