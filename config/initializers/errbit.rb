Airbrake.configure do |config|
  config.api_key = '8ba0d78659af87610dc190f0c0e645ef'
  config.host    = 'didil-errbit.herokuapp.com'
  config.port    = 80
  config.secure  = config.port == 443
end