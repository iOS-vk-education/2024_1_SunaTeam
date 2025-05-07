platform :ios, '15.0'

target 'SunaTravel' do
  use_frameworks!

  # Pods for SunaTravel
  pod 'YandexMapsMobile', '4.10.1-lite'

  pod 'Firebase/Auth', '10.17.0'
  pod 'Firebase/Firestore', '10.17.0'
  pod 'FirebaseFirestoreSwift'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    if target.name == 'BoringSSL-GRPC'
      target.source_build_phase.files.each do |file|
        if file.settings && file.settings['COMPILER_FLAGS']
          flags = file.settings['COMPILER_FLAGS'].split
          flags.reject! { |flag| flag == '-GCC_WARN_INHIBIT_ALL_WARNINGS' }
          file.settings['COMPILER_FLAGS'] = flags.join(' ')
        end
      end
    end
  end
end
