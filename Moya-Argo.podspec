Pod::Spec.new do |s|
  s.name             = "Moya-Argo"
  s.version          = "5.0.1"
  s.summary          = "Argo mappings for Moya network requests"

  s.description      = <<-DESC
  Extensions to simplify mapping Moya responses using Argo
  DESC

  s.homepage         = "https://github.com/wattson12/Moya-Argo"
  s.license          = 'MIT'
  s.author           = { "Sam Watts" => "samuel.watts@gmail.com" }
  s.source           = { :git => "https://github.com/juvs/Moya-Argo.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/wattson12'

  s.ios.deployment_target = '10.0'
  s.osx.deployment_target = '10.10'
  s.watchos.deployment_target = '2.0'
  s.tvos.deployment_target = '9.0'

  s.default_subspec = "Core"

  s.subspec "Core" do |ss|
    ss.source_files = "Pod/Classes/*.swift"
    ss.dependency "Moya", "~> 14.0.0"
    ss.dependency "Argo", "~> 4.1.2"
    ss.framework = "Foundation"
  end

  s.subspec "ReactiveSwift" do |ss|
    ss.source_files = "Pod/Classes/ReactiveSwift/*.swift"
    ss.dependency "Moya-Argo/Core"
    ss.dependency "Moya/ReactiveSwift"
  end

  s.subspec "RxSwift" do |ss|
    ss.source_files = "Pod/Classes/RxSwift/*.swift"
    ss.dependency "Moya-Argo/Core"
    ss.dependency "Moya/RxSwift"
  end

end
