Pod::Spec.new do |s|

  s.name         = "MiniObservable"
  s.version      = "1.5.0"
  s.summary      = "A micro-framework for native key value observable types."
  s.description  = "Simple Observable Object & KVO Replacement. Read my blog post for more details: http://leojkwan.com/2017/03/observables-and-dispose-bags"
  s.homepage     = "https://github.com/leojkwan/MiniObservable"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Leo Kwan" => "leojkwan@gmail.com" }
  s.platform     = :ios, "8.0"

  #  When using multiple platforms
  # s.ios.deployment_target = "5.0"
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"

  s.source       = { :git => "https://github.com/leojkwan/MiniObservable.git", :tag => s.version.to_s }
  s.source_files  = "MiniObservable", "MiniObservable/**/*.{h,m,swift}"
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4' }
  # s.dependency "JSONKit", "~> 1.4"

end
