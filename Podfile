platform :ios, '15.0'

target 'SunaTravel' do
  use_frameworks!

  # Pods for SunaTravel
  pod 'YandexMapsMobile', '4.10.1-lite'
  
  pod 'Firebase/Auth'
  
  pod 'Firebase/Firestore'
  
  pod 'FirebaseFirestoreSwift'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    if target.name == 'BoringSSL-GRPC'
      target.build_configurations.each do |config|
        config.build_settings['OTHER_CFLAGS'] = ['-Qunused-arguments'] 
        config.build_settings['OTHER_CPLUSPLUSFLAGS'] = ['-Qunused-arguments']
      end
    end
  end
end
