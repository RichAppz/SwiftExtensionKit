Pod::Spec.new do |s|
  s.name = 'SwiftExtensionKit'
  s.version = '1.0.0'
  s.license = 'MIT'
  s.summary = 'SwiftExtensionKit - Foundation and UIKit Helper Extensions'
  s.homepage = 'https://richappz.com'
  s.source = { :git => 'git@github.com:RichAppz/SwiftExtensionKit.git', :tag => s.version }
  s.authors = { 'Rich Mucha' => 'rich@richappz.com' }
  
  s.ios.deployment_target = '12.0'
  
  s.source_files = 'Source/**/*.{swift}'
  s.swift_versions = '5.0'
  
  s.static_framework = true

end 

