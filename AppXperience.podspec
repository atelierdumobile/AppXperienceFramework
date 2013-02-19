Pod::Spec.new do |s|
  s.name         = "AppXperience"
  s.version      = "1.1"
  s.summary      = "AppXperience is an advertising fmk of mobile applications."
  s.homepage     = "https://github.com/atelierdumobile/AppXperienceFramework.git"
  s.license      =  'Proprietary'
  s.author       = { "Nicolas Lauquin" => "nicolas@atelierdumobile.com" }
  s.source       = { :git => "https://github.com/atelierdumobile/AppXperienceFramework.git" } #, :tag => "1.1"
  s.platform     = :ios, '5.0'

  s.source_files = 'AppXperience.framework/Versions/A/Headers/*.{h}'
  s.resources    = 'AppXperience.bundle'
  s.frameworks   = 'QuartzCore', 'CoreGraphics', 'UIKit', 'AppXperience'
  s.xcconfig     =  { 'FRAMEWORK_SEARCH_PATHS' => '"$(PODS_ROOT)/AppXperience/"' }
  s.preserve_paths =  'AppXperience.framework', 'AppXperience.bundle'
  #s.library =

  s.dependency 'MKNetworkKit', '~> 0.85'
  s.dependency 'SDWebImage', '~> 3.1'
  
end
