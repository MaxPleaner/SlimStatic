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

		["./src/pages", "./src/public"].each do |dir_prefix|
			Dir.glob("#{dir_prefix}/**/*").each do |src|
				dest = src.gsub("/src/", "/dist/").gsub("/pages/", "/")
				if File.directory?(src)
					FileUtils.mkdir_p(dest)
				else
					if dest.end_with?(".slim")
						dest.gsub!(".slim", ".html")
						render_slim(src, dest)
					else
						FileUtils.copy(src, dest)
					end
				end
			end
		end
		
		puts "done"
	end
end

if __FILE__ == $0
	SiteBuilder.run
end