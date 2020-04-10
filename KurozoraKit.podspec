Pod::Spec.new do |s|
  s.name             = 'KurozoraKit'
  s.version          = '0.1.0'
  s.summary          = 'KurozoraKit is a simple to use framework for interacting with the Kurozora API.'
  s.description      = <<-DESC
	KurozoraKit lets users manage their anime library and access many other serices from your app. When users provide permission to access their Kurozora account, they can use your app to share anime, add anime to their library, and discover any of the millions of anime in the Kurozora catalog. If your app detects that the user is not yet a Kurozora member, you can offer them to create an account within your app.
                       DESC
  s.homepage         = 'https://github.com/kiritokatklian/KurozoraKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'AGPL-3.0', :file => 'LICENSE' }
  s.author           = { 'kiritokatklian' => 'casillaskhoren1@gmail.com' }
  s.source           = { :git => 'https://github.com/kiritokatklian/KurozoraKit.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/katklian'

  s.ios.deployment_target = '12.0'

  s.source_files = 'KurozoraKit/Classes/**/*'
  s.swift_version = '5.1'
  
  # s.resource_bundles = {
  #   'KurozoraKit' => ['KurozoraKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'KeychainAccess'
  s.dependency 'Kingfisher'
  s.dependency 'SCLAlertView', '~> 0.8.3'
  s.dependency 'TRON'
  s.dependency 'TRON/SwiftyJSON'
end
