CarrierWave.configure do |config|
  config.fog_provider = 'fog-google'                        # required
  config.fog_credentials = {
    provider:                         'Google',
    google_storage_access_key_id:     'xxxxxx',
    google_storage_secret_access_key: 'yyyyyy'
  }
  config.fog_directory = 'name_of_directory'
end