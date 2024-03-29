require 'sidekiq'
require 'sidekiq/web'
require 'sidekiq/extensions/active_record'

Sidekiq.configure_client do |config|
  config.redis = { :size => 1, url: "redis://redis:6379" }
end

Sidekiq.configure_server do |config|
  config.redis = { size: 12, url: "redis://redis:6379" }
end