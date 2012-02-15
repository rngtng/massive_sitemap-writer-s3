$:.unshift File.expand_path("../../lib", __FILE__)
require 'bundler/setup'
require 'massive_sitemap-writer-s3'


  def setup
    @buckets_list_body = <<-EOBuckets
    <?xml version="1.0" encoding="UTF-8"?>\n<ListAllMyBucketsResult xmlns="http://s3.amazonaws.com/doc/2006-03-01/"> <Owner> <ID>123u1odhkhfoadf</ID> <DisplayName>JohnDoe</DisplayName> </Owner> <Buckets> <Bucket> <Name>data.example.com</Name> <CreationDate>2009-07-02T11:56:58.000Z</CreationDate> </Bucket> <Bucket> <Name>images</Name> <CreationDate>2009-06-05T12:26:33.000Z</CreationDate> </Bucket> </Buckets> </ListAllMyBucketsResult>
    EOBuckets

    @bucket_not_exists = <<-EOBucketNoexists
    <?xml version="1.0" encoding="UTF-8"?>\n<Error> <Code>NoSuchBucket</Code> <Message>The specified bucket does not exists</Message> <BucketName>data2.example.com</BucketName> <RequestId>8D7519AAE74E9E99</RequestId> <HostId>DvKnnNSMnPHd1oXukyRaFNv8Lg/bpwhuUtY8Kj7eDLbaIrIT8JebSnHwi89AK1P+</HostId> </Error>
    EOBucketNoexists

    @bucket_exists = <<-EOBucketexists
    <?xml version="1.0" encoding="UTF-8"?>\n<ListBucketResult xmlns="http://s3.amazonaws.com/doc/2006-03-01/"> <Name>data.synergypeople.net</Name> <Prefix></Prefix> <Marker></Marker> <MaxKeys>1000</MaxKeys> <IsTruncated>false</IsTruncated> </ListBucketResult>
    EOBucketexists

    @service_empty_buckets_list = S3::Service.new(
      :access_key_id =>  "12345678901234567890",
      :secret_access_key =>  "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDF"
    )
    @response_empty_buckets_list = Net::HTTPOK.new("1.1", "200", "OK")
    @service_empty_buckets_list.stubs(:service_request).returns(@response_empty_buckets_list)
    @response_empty_buckets_list.stubs(:body).returns(@buckets_empty_list_body)

    @service_buckets_list = S3::Service.new(
      :access_key_id =>  "12345678901234567890",
      :secret_access_key =>  "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDF"
    )
    @response_buckets_list = Net::HTTPOK.new("1.1", "200", "OK")
    @service_buckets_list.stubs(:service_request).returns(@response_buckets_list)
    @response_buckets_list.stubs(:body).returns(@buckets_list_body)

    @service_bucket_exists = S3::Service.new(
      :access_key_id =>  "12345678901234567890",
      :secret_access_key =>  "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDF"
    )
    @response_bucket_exists = Net::HTTPNotFound.new("1.1", "200", "OK")
    @service_bucket_exists.stubs(:service_request).returns(@response_bucket_exists)
    @response_bucket_exists.stubs(:body).returns(@bucket_exists)

    @service_bucket_not_exists = S3::Service.new(
      :access_key_id =>  "12345678901234567890",
      :secret_access_key =>  "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDF"
    )
    @response_bucket_not_exists = Net::HTTPNotFound.new("1.1", "404", "Not Found")
    @service_bucket_not_exists.stubs(:service_request).raises(S3::Error::NoSuchBucket.new(404, @response_bucket_not_exists))
    @response_bucket_not_exists.stubs(:body).returns(@bucket_not_exists)

    @buckets_empty_list = []
    @buckets_empty_list_body = <<-EOEmptyBuckets
    <?xml version="1.0" encoding="UTF-8"?>\n<ListAllMyBucketsResult xmlns="http://s3.amazonaws.com/doc/2006-03-01/"> <Owner> <ID>123u1odhkhfoadf</ID> <DisplayName>JohnDoe</DisplayName> </Owner> <Buckets> </Buckets> </ListAllMyBucketsResult>
    EOEmptyBuckets

    @buckets_list = [
      S3::Bucket.send(:new, @service_buckets_list, "data.example.com"),
      S3::Bucket.send(:new, @service_buckets_list, "images")
    ]
  end
