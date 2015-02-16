module PianobarNotify
  class Notification
    def call
      notify
    end

    private

      def notify
        Libnotify.show do |notify|
          notify.summary    = summary
          notify.body       = body
          notify.timeout    = 10
          notify.urgency    = :normal
          notify.append     = false
          notify.transient  = true
          notify.icon_path  = cover.path
        end
      end

      def blob
        @blob ||= Blob.instance
      end

      def summary
        "Pianobar - #{status}"
      end

      # artistbookmark songban songbookmark songexplain songfinish songlove songmove
      # songshelf songstart stationaddgenre stationaddmusic stationaddshared stationcreate
      # stationdelete stationdeleteartistseed stationdeletefeedback stationdeletesongseed
      # stationfetchinfo stationfetchplaylist stationfetchgenre stationquickmixtoggle
      # stationrename userlogin usergetstations
      def status
        case blob.action
        when "songlove"
          "Thumbs Up"
        when "songban"
          "Thumbs Down"
        else
          "Playing"
        end
      end

      def body
        "#{blob.artist} - #{blob.title}\n" <<
        "#{blob.album}\n" <<
        "On: #{blob.station_name}".tap do |b|
          b << "\nThumbs Up" if blob.thumbs_up?
        end
      end

      def cover
        @cover ||= Cover.new
      end
  end

end
