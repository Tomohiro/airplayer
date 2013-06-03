require 'uri'
require 'mime/types'

module AirPlayer
  # http://developer.apple.com/library/ios/#documentation/AudioVideo/Conceptual/AirPlayGuide/PreparingYourMediaforAirPlay/PreparingYourMediaforAirPlay.html
  #
  # File Extension | MIME type       | Ruby `mime-types`
  # -------------- | --------------- | -----------------------------
  # .ts            | video/MP2T      | video/MP2T 
  # .mov           | video/quicktime | video/quicktime
  # .m4v           | video/mpeg4     | video/vnd.objectvideo
  # .mp4           | video/mpeg4     | application/mp4, video/mp4
  SUPPORTED_MIME_TYPES = %w(
    application/mp4
    video/mp4
    video/vnd.objectvideo
    video/MP2T
    video/quicktime
    video/mpeg4
  )

  SUPPORTED_DOMAINS = %w(
    youtube
    youtu.be
  )

  class Media
    attr_reader :title, :path, :type, :local

    def initialize(target)
      path = File.expand_path(target)

      if File.exist? path
        @video_server = AirPlayer::Server.new(path)
        @path  = @video_server.uri
        @title = File.basename(path)
        @type  = :video
        @local = true
      else
        uri = URI.encode(target)
        @path  = online_media_path(uri)
        @title = online_media_title(uri)
        @type  = :video
        @local = false
      end
    end

    def self.playable?(path)
      MIME::Types.type_for(path).each do |mimetype|
        return SUPPORTED_MIME_TYPES.include?(mimetype)
      end

      host = URI.parse(path).host
      SUPPORTED_DOMAINS.each do |domain|
        return true if host =~ /#{domain}/
      end

      false
    end

    def open
      if local? && video?
        @video_server.start
      end
      @path
    end

    def close
      if local? && video?
        @video_server.stop
      end
    end

    def video?
      @type == :video
    end

    def local?
      @local == true
    end

    private
      def online_media_path(uri)
        case URI.parse(uri).host
        when /youtube|youtu\.be/
          uri = `youtube-dl -g #{uri}`
        else
          uri
        end
      end

      def online_media_title(uri)
        case URI.parse(uri).host
        when /youtube|youtu\.be/
          title = `youtube-dl -e #{uri}`
        else
          title = File.basename(uri)
        end
      end
  end
end
