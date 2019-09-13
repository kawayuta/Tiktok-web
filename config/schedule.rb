# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

every :hour do # Many shortcuts available: :hour, :day, :month, :year, :reboot
  rake '-s sitemap:refresh'
end

every 12.hours do
  rake "task_database:get_trending"
end

every 6.hours do
  rake "task_database:get_tag_data"
  rake "task_database:get_user_data"
  rake "task_database:get_video_data"
end

every 1.day, :at => '12:00 am' do
  rake "task_database:get_video_from_tag"
end

every 1.day, :at => '12:00 pm' do
  rake "task_database:get_video_from_user"
end
