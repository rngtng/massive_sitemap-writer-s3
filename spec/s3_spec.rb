require "spec_helper"
require "fileutils"

describe MassiveSitemap::Writer::S3 do
  let(:object) { mock('object', :"content=" => [], :save => nil) }
  let(:objects) { mock('objects', :find_all => [], :build => object) }
  let(:bucket) { mock('bucket', :objects => objects) }
  let(:service) { mock('service', :buckets => mock('buckets', :find =>  bucket)) }
  let(:writer) { MassiveSitemap::Writer::S3.new(s3_cfg, :keep => true) }
  let(:s3_cfg) { Hash.new(:access_key_id => "ak", :secret_access_key => "sa", :bucket => "bucket") }

  before do
    ::S3::Service.stub(:new).and_return(service)
  end

  describe "initialize" do
    it "creates service" do
      ::S3::Service.should_receive(:new).with(s3_cfg).and_return(service)
      writer
    end

    it "get S3 object service" do
      bucket.should_receive(:objects).and_return(objects)
      writer
    end
  end

  describe "close_stream" do
    let(:filename) { "sitemap.xml.gz" }

    before do
      writer.init!
    end

    context "with keep option" do
      after do
        FileUtils.rm(filename)
      end

      it "uploads to amazon" do
        objects.should_receive(:build).with(filename).and_return(object)
        writer.close!
      end

      it "retries on fails" do
        object.should_receive(:"content=").once().and_raise
        object.should_receive(:"content=").once().and_return(true)
        writer.close!
      end
    end

    context "without keep option" do
      let(:writer) { MassiveSitemap::Writer::S3.new(s3_cfg, :keep => false) }

      it "deletes file on local system" do
        writer.close!
        File.exists?(filename).should be_false
      end
    end
  end
end
