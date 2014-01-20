Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.production?
    provider :facebook, ENV['FB_APP_ID_PROD'], ENV['FB_APP_SECRET_PROD']
  elsif Rails.env.development?
    provider :facebook, ENV['FB_APP_ID_DEV'], ENV['FB_APP_SECRET_DEV']
  end
end