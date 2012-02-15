# Copyright (c) 2012, SoundCloud Ltd., Tobias Bielohlawek

require 's3'
require 'retryable'
require 'massive_sitemap/writer/gzip_file'

module MassiveSitemap
  module Writer
    class S3 < MassiveSitemap::Writer::GzipFile

      def initialize(cfg, options = {})
        @service = ::S3::Service.new(cfg)
        @bucket  = @service.buckets.find(cfg[:bucket])
        super(options)
      end

      protected
      def close_stream(stream)
        @filename = filename
        super
        # upload to amazon
        retryable( :tries => 3 ) do
          @bucket.objects.build(::File.basename(@filename)).tap do |object|
            object.content = ::File.open(@filename)
            object.save
          end
        end
      end

      def load_stream_ids
        @bucket.objects.find_all.each do |object|
          if ::File.extname(object.key) == ::File.extname(filename)
            add_stream_id(object.key, object.last_modified)
          end
        end
      end

    end
  end
end
