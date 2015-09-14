Pod::Spec.new do |s|
  s.name             = "TSActionSheet"
  s.version          = "0.0.1"
  s.platform         = :ios, '8.0'
  s.summary          = "A really easy and beautiful custom UIActionSheet"
  s.description      = <<-DESC
  A really easy and beautiful custom UIActionSheet.
                       DESC
  s.homepage         = "https://github.com/bnolens/TSActionSheet"
  s.license          = "MIT"
  s.author           = { "Benoit Nolens" => "benoit@truestory.io" }
  s.source           = { :git => "https://github.com/bnolens/TSActionSheet.git", :tag => "#{s.version}" }

  s.ios.deployment_target = "8.0"

  s.requires_arc = true
  s.source_files = "Pod/Classes/*.{h,m}", "Pod/Classes/**/*.{h,m}"
  s.resources = "Pod/Classes/**/*.{xib}"
  s.framework = "UIKit"
end
