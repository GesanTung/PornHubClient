source 'https://github.com/cocoapods/specs.git'
platform :ios, '10.0'


workspace 'pronhub.xcworkspace'

target 'pronhub' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  project 'pronhub'
  use_frameworks!
  inhibit_all_warnings!

  # Pods for Collector
  pod 'Alamofire'
  pod 'CodableAlamofire'

  pod 'Kingfisher'
  pod 'SnapKit'
  pod 'Device'


  pod 'FDFullscreenPopGesture'
  pod 'MBProgressHUD'


  pod 'RxAtomic'
  pod 'RxSwift'
  pod 'RxFeedback'
  pod 'RxCocoa'
  pod 'RxDataSources'
  pod 'NSObject+Rx'
  pod 'Moya/RxSwift'
  pod 'DefaultsKit'
  pod 'Then'
  
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        if target.name == 'RxSwift'
            target.build_configurations.each do |config|
                if config.name == 'Debug'
                    config.build_settings['OTHER_SWIFT_FLAGS'] ||= ['-D', 'TRACE_RESOURCES']
                end
            end
        end
    end
end

