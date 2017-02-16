module Jekyll
  module SVGCleaner
    # Disable the write functionality as inherited from StaticFile
    class CleanedFile < StaticFile
      def write(destination)
        false
      end
    end
  end
end
