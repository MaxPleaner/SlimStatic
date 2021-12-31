require 'slim'
require 'fileutils'

class SiteBuilder
	def self.partial(src)
		Tilt.new(src, {pretty: true}).render(self)
	end

	def self.render_slim(src, dest)
		File.open(dest, "w") do |dest_file|
			rendered_html = partial(src)
			dest_file.write(rendered_html)
		end
	end

	def self.run
		FileUtils.rm_rf("./dist/.", secure: true)
		FileUtils.mkdir("./dist/public")
		Dir.glob("./src/*.slim").each do |src|
			dest = src.gsub("/src/", "/dist/").gsub(".slim", ".html")
			render_slim(src, dest)
			puts "built #{src}"
		end

		Dir.glob("./src/public/**/*").each do |src|
			dest = src.gsub("/src/", "/dist/")
			FileUtils.copy(src, dest)
			puts "built #{src}"
		end
	end
end

if __FILE__ == $0
	SiteBuilder.run
end