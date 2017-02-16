# Jekyll is the static site builder that we are making a plugin for.
#
# @see http://jekyllrb.com/
module Jekyll
  module SVGCleaner
  end
end

# Require dependencies
require 'jekyll'

# Internal requires
%w{generator configuration cleaned_file}.each do |f|
  require "jekyll/svgcleaner/#{f}"
end
