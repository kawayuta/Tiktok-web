class TagHistory < ApplicationRecord


  validates :tag_official_id, uniqueness: true
  validates :tag_title, uniqueness: true
  validates :tag_url, uniqueness: true
  
end
