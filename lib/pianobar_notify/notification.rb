require 'erb'

module PianobarNotify
  class Notification
    def call
      notify
    end

    private

      def notify
        Libnotify.show do |notify|
          notify.app_name  = "Pianobar"
          notify.summary   = summary
          notify.body      = body
          notify.timeout   = 10
          notify.append    = false
          notify.transient = true
          notify.icon_path = cover.path
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
        ERB.new(body_template, nil, "-").result(binding).gsub(/&/, "&amp;")
      end

      def body_template
        File.read(template_name)
      end

      def template_name
        File.expand_path(
          File.join(
            File.dirname(__FILE__), "..", "..", "templates", "notification", "body.erb"
          )
        )
      end

      def cover
        @cover ||= Cover.new
      end
  end

end
