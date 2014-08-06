Promise = require "bluebird"
fs = require "fs"
AWS = require "aws-sdk"
AWS.config = new AWS.Config
  accessKeyId: process.env.AWS_ACCESS_KEY
  secretAccessKey: process.env.AWS_SECRET_KEY
  region: "us-west-2"
s3 = new AWS.S3
  apiVersion: "2006-03-01"
  endpoint: "https://s3-us-west-2.amazonaws.com"
Promise.promisifyAll s3.constructor::
data = fs.createReadStream "#{__dirname}/bin/flipboard.tar.gz"

s3.putObjectAsync
  Bucket: "com.adamcmiel.app"
  Key: "flipboard.tar.gz"
  ACL: "public-read"
  Body: data
.then (data) ->
  console.log data
.catch (err) ->
  console.error err

