Clerk.configure do |c|
  c.publishable_key = Rails.application.credentials.dig(:clerk, :publishable_key)
  c.secret_key      = Rails.application.credentials.dig(:clerk, :secret_key)
  c.logger = Logger.new(STDOUT) # if omitted, no logging
end
