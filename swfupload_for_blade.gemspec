# Provide a simple gemspec so you can easily use your enginex
# project in your rails apps through git.
Gem::Specification.new do |s|
  s.name            = "swfupload_for_blade"
  s.summary         = "Quickly Add file upload for Blade Yu"
  s.description     = "Quickly Add file upload for Blade Yu"
  s.platform        = Gem::Platform::RUBY
  
  %w(generators).each do |dir|
    s.files         += Dir["#{dir}/**/*"]
  end
  
  s.version         = "1.0.0"
  s.require_path    = "lib"
end