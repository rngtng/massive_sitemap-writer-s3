require 's3'
require 'massive_sitemap/writer/gzip_file'

module MassiveSitemap
  module Writer
    class S3 < MassiveSitemap::Writer::GzipFile

      def initialize(cfg, options = {})
        @service = ::S3::Service.new(cfg)
        @bucket  = @service.buckets.find(cfg[:bucket])
        super(options)

        # read sreams, tale filename (without ext as filter),order DESC
        # delete last file
        # delete random files
        # prefix = ::File.basename(current, ".xml.gz")
        # @streams = @bucket.objects.find_all(:prefix => prefix).map(&:key)
      end

      protected
      def close_stream(stream)
        @filename = filename
        super
        @bucket.objects.build(::File.basename(@filename)).tap do |object|
          object.content = ::File.open(@filename)
          object.save
        end
        # add to stream
        # @streams << current
      end

      def init?
        # check if file is part of streams, fail if so
        #if !options[:force_overwrite] && streams.include?(filename)
        #  raise FileExistsException, "Can not create file: #{filename} exits"
        #end
        super
      end

      def streams
        # @streams
        super
      end

    end
  end
end
