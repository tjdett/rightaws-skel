require 'bundler'
Bundler.setup

require 'uri'
require 'right_aws'

module RightAws
  class S3Interface
    def is_dns_bucket?(bucket_name)
      false
    end
  end
end

[:S3_URL, :EC2_ACCESS_KEY, :EC2_SECRET_KEY].each do |v|
  raise ArgumentError.new("Need %s env var set." % v) unless ENV.key?(v.to_s)
end
server = URI(ENV['S3_URL'])

s3 = RightAws::S3.new(
  ENV['EC2_ACCESS_KEY'],
  ENV['EC2_SECRET_KEY'],
  {
    :server => server.host,
    :port => server.port,
    :protocol => server.scheme
  })

s3.buckets.each do |b|
  puts "%s" % b.name
  b.keys.each do |k|
    puts "- %s" % k
  end
end

