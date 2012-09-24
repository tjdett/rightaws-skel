require 'bundler'
Bundler.setup

require 'uri'
require 'right_aws'

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

puts "Existing buckets: %s" % s3.buckets.map{|b| b.name}.inspect

