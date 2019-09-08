Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://localhost:6379', namespace: 'myapp' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://localhost:6379', namespace: 'myapp' }
end

ENV['REDIS_NAMESPACE_QUIET'] = 'true'
