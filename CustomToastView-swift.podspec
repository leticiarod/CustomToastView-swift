#
# Be sure to run `pod lib lint CustomToastView-swift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CustomToastView-swift'
  s.version          = '0.1.1'
  s.summary          = 'A small framework to display toast messages in Swift.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
CustomToastView is a small and lightweight Swift framework that allows you to display custom toast messages in an super-easy way!
                       DESC

  s.homepage         = 'https://github.com/leticiarod/CustomToastView-swift'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'leticiamrgs@gmail.com' => 'leticiamrgs@gmail.com' }
  s.source           = { :git => 'https://github.com/leticiarod/CustomToastView-swift.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'Source/*.{swift,xib}'
  
  s.swift_version = "5.0"
  # s.resource_bundles = {
  #   'CustomToastView-swift' => ['CustomToastView-swift/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
