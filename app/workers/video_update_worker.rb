class VideoUpdateWorker < ApplicationController
  include Sidekiq::Worker

  sidekiq_options unique_across_workers: true, queue: 'default', lock: :until_executed
  def perform(official_id, user_instance)
    Video.new_video(official_id, user_instance)
  end
end
