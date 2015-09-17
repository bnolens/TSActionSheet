Pod::Spec.new do |s|
  s.name             = "TSActionSheet"
  s.version          = "0.1.5"
  s.platform         = :ios, '8.2'
  s.summary          = "A really easy and beautiful custom UIActionSheet"
  s.description      = <<-DESC
  A really easy and beautiful custom UIActionSheet.
  * Block callback
  * Customizable colors
  * Customizable fonts
  * Customizable background
                       DESC
  s.homepage         = "https://github.com/bnolens/TSActionSheet"
  s.license          = { :type => "MIT", :file => "LICENSE.txt" }
  s.author           = { "Benoit Nolens" => "benoit@truestory.io" }
  s.source           = { :git => "https://github.com/bnolens/TSActionSheet.git", :tag => "#{s.version}" }

  s.ios.deployment_target = "8.2"

  s.requires_arc = true
  s.source_files = "Pod/Classes/**/*.{h,m}"
  s.resource_bundles = {
    "UserInterface" => ["Pod/Classes/**/*.{xib}"]
  }
  s.framework = "UIKit"
end
