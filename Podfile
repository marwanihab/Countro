# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

target 'CountriesTask' do
# Comment the next line if you don't want to use dynamic frameworks
use_frameworks!

# Pods for Task

pod 'Firebase/Core'
pod 'Firebase'
pod 'Firebase/Auth'
pod 'Firebase/Database'
pod 'FBSDKCoreKit'
pod 'FBSDKLoginKit'
pod 'SVProgressHUD'
pod 'Firebase/Auth'
pod 'GoogleSignIn'
pod 'SwiftyJSON', '~> 5.0.0'
pod 'Alamofire'




end

post_install do |installer|
installer.pods_project.targets.each do |target|
target.build_configurations.each do |config|
config.build_settings['CLANG_WARN_DOCUMENTATION_COMMENTS'] = 'NO'
end
end
end

