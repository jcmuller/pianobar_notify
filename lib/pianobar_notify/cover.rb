require 'open-uri'
require 'mini_magick'
require 'tempfile'

module PianobarNotify
    #coverArt=http://cont-sjl-1.pandora.com/images/public/amz/5/2/0/4/037627044025_500W_500H.jpg
  class Cover
    #puts blob.data.cover_art
    def path
      confirm_it_exists
      image_name
    end

    private

    attr_reader :temp_image

      def confirm_it_exists
        unless File.exists?(image_path)
          download_and_convert
        end
      end

      def download_and_convert
        download
        convert
      end

      def download
        tempfile.binmode
        tempfile.print(cover_image)
        tempfile.seek(0)
      end

      def tempfile
        @tempfile ||= Tempfile.new(["cover", ".jpg"])
      end

      def convert
        image = MiniMagick::Image.open(tempfile.path)
        image.resize "72x72"
        image.format "png"
        image.write image_path
      end

      def image_path
        File.join(COVER_PATH, image_name)
      end

      def image_name
        @image_name ||= [
          blob.artist,
          blob.album
        ].join("-").gsub(/ /, "_").gsub(%r{/?.}, "").downcase << ".png"
      end

      def blob
        @blob ||= Blob.instance
      end

      def cover_image
        open(blob.cover_art).read
      end
  end
end
