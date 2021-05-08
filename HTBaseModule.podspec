#
# Be sure to run `pod lib lint HTBaseModule.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HTBaseModule'
  s.version          = '0.2.4'
  s.summary          = 'A short description of HTBaseModule.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/NSLogMu/HTBaseModule'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'NSLogMu' => '872365538@qq.com' }
  s.source           = { :git => 'https://github.com/NSLogMu/HTBaseModule.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'HTBaseModule/Classes/*.*'
  
  # s.resource_bundles = {
  #   'HTBaseModule' => ['HTBaseModule/Assets/*.png']
  # }
  
  s.subspec 'BaseView' do |ss|
       ss.source_files = 'HTBaseModule/Classes/BaseView/*.{h,m}'
    end

  s.subspec 'Category' do |ss|
     ss.source_files = 'HTBaseModule/Classes/Category/*.{h,m}'
  end
  
  s.subspec 'Define' do |ss|
     ss.source_files = 'HTBaseModule/Classes/Define/*.{h,m}'
  end
  
  s.subspec 'Network' do |ss|
     ss.source_files = 'HTBaseModule/Classes/Network/*.{h,m}'
     
     ss.subspec 'NetworkData' do |sss|
     sss.source_files = 'HTBaseModule/Classes/Network/NetworkData/*.{h,m}'
     end
     
     ss.subspec 'PLNetworking' do |sss|
     sss.source_files = 'HTBaseModule/Classes/Network/PLNetworking/*.{h,m}'
     end
     
     ss.subspec 'PLNetworkingConfig' do |sss|
     sss.source_files = 'HTBaseModule/Classes/Network/PLNetworkingConfig/*.{h,m}'
     end
     
     ss.subspec 'Reachability' do |sss|
     sss.source_files = 'HTBaseModule/Classes/Network/Reachability/*.{h,m}'
     end
     
  end
  
  s.subspec 'Tools' do |ss|
     ss.source_files = 'HTBaseModule/Classes/Tools/*.{h,m}'
  end
  
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
   s.dependency 'MBProgressHUD', '~> 1.0.0'
   s.dependency 'Masonry', '~> 0.6.2'
   s.dependency 'AFNetworking', '~> 4.0'
   s.dependency 'YYKit'
   s.dependency 'MJExtension', '~> 2.5.6'
end
