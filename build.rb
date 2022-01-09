require 'slim'
require 'fileutils'
require 'pry'

class SiteBuilder
	PartialData = {}

	def self.set_partial_data(**data, &blk)
		PartialData.merge!(data)
		result = blk.call
		PartialData.clear
		result
	end

	def self.partial(src, **data)
		set_partial_data(**data) do
			Tilt.new(src, {pretty: true}).render(self, data)
		end
	end

	def self.render_slim(src, dest, **data)
		File.open(dest, "w") do |dest_file|
			rendered_html = partial(src, **data)
			dest_file.write(rendered_html)
		end
	end

	def self.run
		FileUtils.rm_rf("./dist/.", secure: true)
		FileUtils.mkdir_p("./dist/public")
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