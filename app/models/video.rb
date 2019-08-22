class Video < ApplicationRecord
  serialize :video_tags

  belongs_to :user
end
