require 'fileutils'
require 'mkmf'

module Jekyll
  module SVGCleaner
    class Generator < ::Jekyll::Generator
      safe true
      priority :high

      # Plugin entry point
      #
      # @param site [Jekyll::Site] The site to generate for
      # @return [void]
      def generate(site)
        puts ''
        puts 'Jekyll SVGCleaner...'

        @site = site

        config = configuration(@site.source)
        unless File.exist? config[:svg_path]
          puts "Unable to find a valid configuration: svg_path=#{config[:svg_path]}"
          return
        end


        unless find_executable 'svgcleaner'
          puts "Cannot find `svgcleaner' in your PATH variable. " +
               "Is `svgcleaner' installed correctly?"

          return
        end

        puts "Cleaning SVG files... "

        svg_files = Dir["#{config[:svg_path]}/*.svg"]

        FileUtils.mkdir_p(config[:images_path]) unless
          File.exist?(config[:images_path])

        svg_files.each do |file|
          file_output = "#{config[:images_path]}/#{File.basename(file)}"

          puts "#{file} => #{file_output}"

          puts `svgcleaner #{file} #{file_output}`

          site.static_files << CleanedFile.new(site, site.dest,
                                               config[:images_dir],
                                               File.basename(file))
        end
      end

      private

      # Compile a configuration Hash from sane defaults mixed with user input
      # from `_data/svgcleaner.yml`.
      #
      # @param source [String] The project source folder
      # @return [::SVGCleaner::Configuration]
      def configuration(source)
        config = Configuration.default_configuration

        config.extend(@site.data['svgcleaner'] || {})
        unless config.has_key? :svg_path
          config[:svg_path] = File.join(source, config[:svg_dir])
        end

        unless config.has_key? :images_path
          config[:images_path] = File.join(source, "_site/#{config[:images_dir]}")
        end

        config
      end

    end
  end
end
