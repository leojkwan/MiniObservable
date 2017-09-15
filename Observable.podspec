Pod::Spec.new do |s|

  s.name         = "Observable"
  s.version      = "1.1.0"
  s.summary      = "A micro-framework for native key value observable types."
  s.description  = "Simple Observable Object & KVO Replacement. Read my blog post for more details: http://leojkwan.com/2017/03/observables-and-dispose-bags"
  s.homepage     = "https://github.com/leojkwan/Observable"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Leo Kwan" => "leojkwan@gmail.com" }
  s.platform     = :ios, "8.0"

  #  When using multiple platforms
  # s.ios.deployment_target = "5.0"
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"

  s.source       = { :git => "https://github.com/leojkwan/Observable.git", :tag => "1.1.0" }
  s.source_files  = "Observable", "Observable/**/*.{h,m,swift}"
  s.exclude_files = "Classes/Exclude"
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3' }
  # s.dependency "JSONKit", "~> 1.4"

end
