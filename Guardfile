# https://github.com/guard/guard#readme

require './build.rb'

guard :shell do
  watch(/src\/(.*)/) do |match|
    SiteBuilder.run
  end
end