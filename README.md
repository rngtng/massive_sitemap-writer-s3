# MassiveSitemap S3 Writer [![](http://travis-ci.org/rngtng/massive_sitemap-writer-s3.png)](http://travis-ci.org/rngtng/massive_sitemap-writer-s3)

S3 Writer extension for [MassiveSitemap](http://rngtng/massive_sitemap)

## Usage

_S3 Writer_ extends `MassiveSitemap::Writer::GzipFile` for uploading the generated siemap file directly to
S3. The state of the sitemap files is read from there too, which makes permanenty storage of the files localy obsolete.

For initialization the S3 options are required as first parameter:

```ruby
require 'massive_sitemap'
require 'massive_sitemap/writer/s3'

s3_options = { :access_key_id => ..., :secret_access_key => ..., :bucket => ... }
writer = MassiveSitemap::Writer::S3.new(s3_options)

MassiveSitemap::generate(:url => ..., :writer => writer)

```

## Dependencies

Obviously depends on a S3 library which is the fabouly slick [S3 gem](https://github.com/qoobaa/s3).

For further information check [Massive Sitemap gem](http://rngtng/massive_sitemap)


## Contributing

We'll check out your contribution if you:

- Provide a comprehensive suite of tests for your fork.
- Have a clear and documented rationale for your changes.
- Package these up in a pull request.

We'll do our best to help you out with any contribution issues you may have.


## License

The license is included as LICENSE in this directory.
