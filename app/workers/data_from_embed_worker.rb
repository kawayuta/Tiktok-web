class DataFromEmbedWorker < ApplicationController
  include Sidekiq::Worker

  sidekiq_options unique_across_workers: true, queue: 'default', lock: :until_executed
  def perform(url, is_trending)
    Tag.get_data_from_embed(url, is_trending)
  end
end
