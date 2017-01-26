#
# Be sure to run `pod lib lint DGNotifyView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DGNotifyView'
  s.version          = '0.1.1'
  s.summary          = 'Animated view for internal app notifications'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Animated view for in-app notifications. With this you can quickly generate a customisable UIView to notify the user.
                       DESC

  s.homepage         = 'https://github.com/glowcap/DGNotifyView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'glowcap' => 'doku005@yahoo.com' }
  s.source           = { :git => 'https://github.com/glowcap/DGNotifyView.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/daymeing'

  s.ios.deployment_target = '9.0'

  s.source_files = 'DGNotifyView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'DGNotifyView' => ['DGNotifyView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
