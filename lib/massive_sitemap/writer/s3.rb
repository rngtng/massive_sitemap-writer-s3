require 's3'
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
        # TODO what if fail??
        @bucket.objects.build(::File.basename(@filename)).tap do |object|
          object.content = ::File.open(@filename)
          object.save
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
