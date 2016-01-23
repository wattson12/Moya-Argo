#
# Be sure to run `pod lib lint Moya-Argo.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "Moya-Argo"
  s.version          = "0.1.0"
  s.summary          = "A short description of Moya-Argo."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
                       DESC

  s.homepage         = "https://github.com/<GITHUB_USERNAME>/Moya-Argo"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Sam Watts" => "samuel.watts@gmail.com" }
  s.source           = { :git => "https://github.com/<GITHUB_USERNAME>/Moya-Argo.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.default_subspec = "Core"

  s.subspec "Core" do |ss|
    ss.source_files  = "Pod/Classes/*.swift"
    ss.dependency "Moya"
    ss.dependency "Argo"
    ss.framework  = "Foundation"
  end

  s.subspec "ReactiveCocoa" do |ss|
    ss.source_files = "Pod/Classes/ReactiveCocoa/*.swift"
    ss.dependency "Moya-Argo/Core"
    ss.dependency "Moya/ReactiveCocoa"
  end

  s.subspec "RxSwift" do |ss|
    ss.source_files = "Pod/Classes/RxSwift/*.swift"
    ss.dependency "Moya-Argo/Core"
    ss.dependency "Moya/RxSwift"
  end

end
