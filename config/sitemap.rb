# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://tiktok-pro.com"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end

  add root_path, :priority => 0.5, :changefreq => 'daily'
  Tag.find_each do |tag|
    add tag_path(tag), :lastmod => tag.updated_at, :changefreq => 'always'
    add ranking_tag_path(tag), :lastmod => tag.updated_at, :changefreq => 'daily'
  end
  User.find_each do |user|
    add user_path(user), :lastmod => user.updated_at, :changefreq => 'always'
  end
  Video.find_each do |video|
    add video_path(video), :lastmod => video.updated_at, :changefreq => 'always'
  end
end
