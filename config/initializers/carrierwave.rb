
CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',       # required
   # :aws_access_key_id      => 'ACCESS_KEY',       # required
   # :aws_secret_access_key  => 'SECRET_KEY'#,       # required
    #:region                 => 'eu-west-1'#'us-west-2'  # required, defaults to 'us-east-1'
    
  }
  config.fog_directory  = 'o-meter-img'

end
