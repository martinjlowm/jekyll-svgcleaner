require 'yaml'

module Jekyll
  module SVGCleaner
    class Configuration
      CONFIGURATION_NAME = 'Jekyll::SVGCleaner'

      def extend(hash)
        hash.each do |key, value|
          self[key] = value
        end
      end

      def delete(key)
        @data.delete(key)
      end

      def has_key?(key)
        @data.has_key?(key)
      end

      def []=(key, value)
        key = key.to_sym unless key.is_a? Symbol

        if value.is_a? Hash
          @data[key] = {} unless @data[key].is_a? Hash
          value.each do |subkey, subvalue|
            subkey = subkey.to_sym unless subkey.is_a? Symbol
            @data[key][subkey] = subvalue
          end
        else
          @data[key] = value
        end

      end

      def [](key)
        @data[key]
      end

      private

      def initialize(initial_hash = {})
        @data = initial_hash
      end

      class << self
        def default_configuration
          new({
              :svg_dir => '_svg',
              :images_dir => 'images',
          })
        end

        def from_yaml_file(filename)
          config = default_configuration
          YAML.load_file(filename).each do |k, v|
            config[k.to_sym] = v
          end
          config
        end
      end
    end
  end
end
