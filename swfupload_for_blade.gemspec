# Provide a simple gemspec so you can easily use your enginex
# project in your rails apps through git.
Gem::Specification.new do |s|
  s.name            = "swfupload_for_blade"
  s.summary         = "Quickly Add file upload for Blade Yu"
  s.description     = "use swfupload + paperclip upload file"
  s.platform        = Gem::Platform::RUBY
  s.author          = "Blade Yu (yakjuly)"
  s.homepage        = "http://www.yakjuly.com"
  s.email           = "yakjuly@gmail.com"
  
  %w(lib example).each do |dir|
    s.files         += Dir["#{dir}/**/*"]
  end
  
  s.version         = "1.0.0"
  s.require_path    = "lib"
  s.autorequire     = "swfupload_for_blade"
end