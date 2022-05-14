# Uncomment the next line to define a global platform for your project
# platform :ios, '11.0'

target 'Pinterest' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Pinterest
  pod 'SDWebImage'
  pod 'Firebase/Core'
  pod 'Firebase/Auth'
  pod 'GoogleSignIn', '~> 5.0'
  pod 'SwiftGifOrigin', '~> 1.7.0'
  pod 'FacebookLogin'
  pod 'FacebookShare'
  pod 'MBProgressHUD', '~> 1.2.0'
  pod 'FBSDKCoreKit'
  pod 'FBSDKLoginKit'
  pod 'FBSDKShareKit'
  pod 'MessageKit'

  


  target 'PinterestTests' do
  inherit! :search_paths
    # Pods for testing
  end

  target 'PinterestUITests' do
    # Pods for testing
  end

end
post_install do |installer|
     installer.pods_project.targets.each do |target|
         target.build_configurations.each do |config|
             config.build_settings['DEBUG_INFORMATION_FORMAT'] = 'dwarf'
             config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
             config.build_settings['ONLY_ACTIVE_ARCH'] = 'YES'
         end
     end
  end

