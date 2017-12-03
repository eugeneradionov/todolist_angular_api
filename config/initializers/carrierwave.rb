CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'

  config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_KEY'],
      region: ENV['S3_REGION']
  }

  if Rails.env.test?
    config.storage = :file
    config.enable_processing = false
    config.root = "#{Rails.root}/tmp"
  else
    config.storage = :fog
  end

  config.fog_directory = ENV['S3_BUCKET_NAME']
  config.cache_dir = "#{Rails.root}/tmp/uploads"
end
