# test AWS
knox = require "knox"

client = knox.createClient
        key: process.env.S3_KEY
        secret: process.env.S3_SECRET
        bucket: "lmi-mullins"

client.putFile "/DimensionData/testFile.txt", "/test/testFile.txt", (err, res)->
    if err
        console.error "unable to upload", err
    else
        console.log "file available at https://lmi-mullins.s3.amazon.com/test/testFile.txt"

client.getFile "/test/testFile.txt", (err, res)->
    if err
        console.error "unable to download", err
    else
        console.log "file downloaded"
