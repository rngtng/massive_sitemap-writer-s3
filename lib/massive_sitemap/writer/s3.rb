require 's3'
require 'massive_sitemap/writer/gzip_file'

module MassiveSitemap
  module Writer
    class S3 < MassiveSitemap::Writer::GzipFile

      def initalize(service, bucket, options = {})
        @service = service
        @bucket  = service.buckets.find(bucket)
        super(options)
      end

      def close_stream(stream)
        super
        @bucket.objects.build(::File.basename(filename)).tap do |object|
          object.content = ::File.open(filename)
          object.save
        end
      end
    end
  end
end
