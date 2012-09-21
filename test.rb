require 'bundler'
Bundler.setup

require 'uri'
require 'right_aws'

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

