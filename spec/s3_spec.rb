require "spec_helper"

describe MassiveSitemap::Writer::S3 do
  let(:service) { }
  let(:bucket) { "example" }
  let(:writer) { MassiveSitemap::Writer::S3.new(service, bucket) }

  it "works" do
    # writer.close_stream(stream)

  end

  describe "initialize" do
    # @stream_ids.clear
    it  "doesn't take streams ids from disk" do
    end
  end

  describe "close_stream" do
     it "uploads to amazon" do
     end
  end
end

