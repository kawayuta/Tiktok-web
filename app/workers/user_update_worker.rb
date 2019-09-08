class UserUpdateWorker < ApplicationController
  include Sidekiq::Worker

  sidekiq_options unique_across_workers: true, queue: 'default', lock: :until_executed
  def perform(official_id)
    User.new_user(official_id)
  end
end
