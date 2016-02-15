Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Code is not reloaded between requests.
  config.cache_classes = true

  # Eager load code on boot. This eager loads most of Rails and
  # your application in memory, allowing both threaded web servers
  # and those relying on copy on write to perform better.
  # Rake tasks automatically ignore this option for performance.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Disable serving static files from the `/public` folder by default since
  # Apache or NGINX already handles this.
  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?


  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  # config.action_controller.asset_host = 'http://assets.example.com'

  # Specifies the header that your server uses for sending files.
  # config.action_dispatch.x_sendfile_header = 'X-Sendfile' # for Apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for NGINX

  # Action Cable endpoint configuration
  # config.action_cable.url = 'wss://example.com/cable'
  # config.action_cable.allowed_request_origins = [ 'http://example.com', /http:\/\/example.*/ ]

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # config.force_ssl = true

  # Use the lowest log level to ensure availability of diagnostic information
  # when problems arise.
  config.log_level = :debug

  # Prepend all log lines with the following tags.
  config.log_tags = [ :request_id ]

  # Use a different logger for distributed setups.
  # require 'syslog/logger'
  # config.logger = ActiveSupport::TaggedLogging.new(Syslog::Logger.new 'app-name')

  # Use a different cache store in production.
  # config.cache_store = :mem_cache_store

  # Use a real queuing backend for Active Job (and separate queues per environment)
  # config.active_job.queue_adapter     = :resque
  # config.active_job.queue_name_prefix = "rails_api_template_#{Rails.env}"

  # Ignore bad email addresses and do not raise email delivery errors.
  # Set this to true and configure the email server for immediate delivery to raise delivery errors.
  # config.action_mailer.raise_delivery_errors = false

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation cannot be found).
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false

  # config.action_mailer.default_url_options = { :host => 'localhost', :port => 3000 }
  # config.action_mailer.raise_delivery_errors = true
  # config.action_mailer.delivery_method = :smtp
  # config.action_mailer.smtp_settings = { :address => "127.0.0.1", :port => 1025 }
  config.action_mailer.perform_deliveries = true

   # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = true

  # config.action_mailer.delivery_method = :smtp
  # SMTP settings for gmail
  # config.action_mailer.smtp_settings = {
  #  :address              => "smtp.gmail.com",
  #  :port                 => 587,
  #  :user_name            => ENV['GMAIL_USERNAME'],
  #  :password             => ENV['GMAIL_PASSWORD'],
  #  :authentication       => "plain",
  # :enable_starttls_auto => true
  # }

  config.action_mailer.delivery_method = :mailgun
  config.action_mailer.mailgun_settings = {
        api_key: ENV['MAILGUN_API_KEY'],
        domain: ENV['MAILGUN_DOMAIN']
        # api_key: 'key-926c7f5f005715aeb4de87c4d8f8cd84',
        # domain: 'https://api.mailgun.net/v3/sandboxb2fe6edf1ce84c44977df8c409357b41.mailgun.org'
  }

  # mailgun

  # config.action_mailer.default_url_options = { host: ENV["MANDRILL_DOMAIN"] }
  # config.action_mailer.smtp_settings = {
  #   :address   => "smtp.mandrillapp.com",
  #   :port      => 25,
  #   :enable_starttls_auto => true,
  #   :user_name => ENV["MANDRILL_USERNAME"],
  #   :password  => ENV["MANDRILL_API_KEY"],
  #   :authentication => 'login',
  #   :domain => ENV["MANDRILL_DOMAIN"]
  # }
end
