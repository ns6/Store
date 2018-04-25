# Podfile

#platform :ios, '10.0'
use_frameworks!

target 'Stores' do
pod 'Firebase/Core'
pod 'Firebase/Firestore'
pod 'TableKit'

	abstract_target 'Tests' do
    	#inherit! :search_paths
    	target "StoresTests"

    	pod 'Quick'
    	pod 'Nimble'
  	end
end
