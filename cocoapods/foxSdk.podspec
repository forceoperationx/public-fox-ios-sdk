#
# Be sure to run `pod lib lint foxSdk.podspec" to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "foxSdk"
  s.version          = "2.16g"
  s.summary          = "FOX SDK for global use."
  s.description      = <<-DESC
                       Pod integration for F.O.X SDK
                       DESC
  s.homepage         = "https://github.com/cyber-z/public-fox-ios-sdk"
  s.license          = {
    :type => "Copyright",
    :text => "Copyright © CyberZ, inc. All Rights Reserved."
  }
  s.author           = "CyberZ inc."
  s.source           = {:http => "https://github.com/cyber-z/public-fox-ios-sdk/releases/download/v#{s.version}/FOX_SDK_iOS_v#{s.version}.zip"}

  s.platform     = :ios, "4.3"
  s.requires_arc = false

  s.source_files = "**/*.{h,m}"
  s.vendored_libraries = "**/*.a"

  s.public_header_files = "**/*.h"

  s.frameworks = "Foundation", "Security", "StoreKit", "iAd"
  s.weak_framework = "SafariServices", "AdSupport"
  s.xcconfig = { "LIBRARY_SEARCH_PATHS" => "$(PODS_ROOT)/#{s.name}" }

end
