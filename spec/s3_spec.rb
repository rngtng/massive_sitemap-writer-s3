require "spec_helper"

describe MassiveSitemap::Writer::S3 do
  let(:service) { }
  let(:bucket) { "example" }
  let(:writer) { MassiveSitemap::Writer::S3.new(service, bucket) }

  it "works" do
    # writer.close_stream(stream)

  end
end
