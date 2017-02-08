source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '8.1'
#inhibit_all_warnings!
use_frameworks!

def corePods
	pod 'DKHelper', '~> 2.2.3'
	pod 'MBProgressHUD', '~> 1.0.0'
	pod 'Polyline', '~> 4.0'
end

target 'TransitApp' do
	corePods
end

target 'TransitAppTests' do
	corePods
end

post_install do |installer|

	installer.pods_project.targets.each do |target|

		target.build_configurations.each do |config|
			config.build_settings['EXPANDED_CODE_SIGN_IDENTITY'] = ""
			config.build_settings['CODE_SIGNING_REQUIRED'] = "NO"
			config.build_settings['CODE_SIGNING_ALLOWED'] = "NO"
			config.build_settings['SWIFT_VERSION'] = '3.0'
		end
	end
end
