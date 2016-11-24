Gem::Specification.new do |s|
  s.name        = 'jekyll-svgcleaner'
  s.version     = '0.1a-1-g04f44e0'
  s.summary     = "Jekyll generator plugin to clean and minify SVG vector files."
  s.description = <<-EOF
    This project integrates with Jekyll, the static website generator, and
    watches changes in SVG vector files and outputs cleaned versions of these.
  EOF
  s.license     = 'MIT'
  s.authors     = ["Martin Jesper Low Madsen"]
  s.email       = 'martin@martinjlowm.dk'
  s.files       = [*Dir["lib/**/*.rb"], "README.org", "LICENSE"]
  s.homepage    = 'https://github.com/martinjlowm/jekyll-svgcleaner'

  s.add_runtime_dependency 'jekyll', '~> 3.0'
end
