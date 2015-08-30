::CarrierWave.configure do |config|
    config.storage             = :qiniu
    config.qiniu_access_key    = 'XCgScHiJh4heRpcy_eNN3iWS72Osg0cc-Li9aZIj'
    config.qiniu_secret_key    = 'cAS2sKDW35hQDahtqDJwKy9hudBoBGZEILVXXZ5o'
    config.qiniu_bucket        = 'soarpatriot'
    config.qiniu_bucket_domain = 'soarpatriot.qiniudn.com'
    confit.qiniu_bucket_private= true
    config.qiniu_block_size    = 4*1024*1024
    config.qiniu_protocol      = "http"
    config.qiniu_can_overwrite = true
    # config.qiniu_up_host       = 'http://up.qiniug.com' #七牛上传海外服务器,国内使用可以不要这行配置
end
