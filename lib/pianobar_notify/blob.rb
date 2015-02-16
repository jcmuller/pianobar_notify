require 'singleton'
require 'ostruct'

module PianobarNotify
  class Blob < OpenStruct
    include Singleton

    def initialize
      super
      self.action = ARGV[0]
      STDIN.each_line do |line|
        key, value = line.chomp.split("=")
        self.send(:"#{cleanup_key(key)}=", value)
      end
    end

    def stations
      @stations ||= self.to_h.select { |k, v| k =~ /^station\d/ }.values
    end

    def thumbs_up?
      self.rating == 1
    end

    private

      def cleanup_key(key)
        key.gsub(/(.)([A-Z])/,'\1_\2').downcase
      end
  end
end
