require 'open-uri'
require 'mini_magick'
require 'tempfile'

module PianobarNotify
  class Cover
    def path
      confirm_it_exists
      image_name
    end

    private

      IMAGE_FORMAT = "png"
      IMAGE_SIZE   = "96x96"

      attr_reader :temp_image

      def confirm_it_exists
        download_and_convert if should_download?
      end

      def should_download?
        !File.exists?(image_path) && !blob.cover_art.nil?
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
        image.resize IMAGE_SIZE
        image.format IMAGE_FORMAT
        image.write image_path
      rescue Errno::ENOENT
        FileUtils.mkdir_p(COVER_PATH)
        retry
      end

      def image_path
        File.join(COVER_PATH, image_name)
      end

      def image_name
        @image_name ||= [
          [
            blob.artist,
            blob.album
          ].join(" - ").gsub(%r{[/\?.&]}, ""),
          IMAGE_FORMAT
        ].join(".")
      end

      def blob
        @blob ||= Blob.instance
      end

      def cover_image
        open(blob.cover_art).read
      end
  end
end
