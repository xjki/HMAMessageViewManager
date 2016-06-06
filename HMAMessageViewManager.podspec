#
# Be sure to run `pod lib lint HMAMessageViewManager.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HMAMessageViewManager'
  s.version          = '0.1.1'
  s.summary          = 'Dead simple notification message banners (appearing from bottom of the view) for iOS'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Dead simple notification message banners (appearing from bottom) for iOS. Xcode 7 and iOS9 SDK.
    * No dependencies
    * Rotation support (uses autolayout)
    * Error, Warning, Success and Default types
    * Customize fonts via UIAppearance
Message banner hides automatically after seconds defined with kMessageViewDismissInSeconds constant or by user tap.
                       DESC

  s.homepage         = 'https://github.com/xjki/HMAMessageViewManager'
  # s.screenshots     = 'https://cloud.githubusercontent.com/assets/747340/11300924/7f996164-8f9b-11e5-9830-9d29793ba143.gif'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jurgis Kirsakmens' => 'jki@jki.lv' }
  s.source           = { :git => 'https://github.com/xjki/HMAMessageViewManager.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/xjki'

  s.ios.deployment_target = '8.0'

  s.source_files = 'HMAMessageViewManager/Classes/**/*'
  
  # s.resource_bundles = {
  #   'HMAMessageViewManager' => ['HMAMessageViewManager/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit'
end
