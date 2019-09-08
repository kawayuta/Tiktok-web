class TagUpdateWorker < ApplicationController
  include Sidekiq::Worker

  sidekiq_options unique_across_workers: true, queue: 'default', lock: :until_executed
  def perform(keyword)
    Tag.new_tag(keyword)
  end
end
