Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :github, "4e314c78a8a648f8eb35", "ed7b41bfd8fc0ee5bdfc2faeb4666a686895121c"
end
