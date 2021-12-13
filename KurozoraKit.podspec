Pod::Spec.new do |s|
  s.name             = 'KurozoraKit'
  s.version          = '0.23.0'
  s.summary          = 'KurozoraKit is a simple to use framework for interacting with the Kurozora API.'
  s.description      = <<-DESC
	KurozoraKit lets users manage their anime library and access many other serices from your app. When users provide permission to access their Kurozora account, they can use your app to share anime, add anime to their library, and discover any of the millions of anime in the Kurozora catalog. If your app detects that the user is not yet a Kurozora member, you can offer them to create an account within your app.
                       DESC
  s.homepage         = 'https://github.com/Kurozora/KurozoraKit'
  s.license          = { :type => 'AGPLv3.0', :file => 'LICENSE' }
  s.author           = { 'kiritokatklian' => 'casillaskhoren1@gmail.com' }
  s.source           = { :git => 'https://github.com/Kurozora/KurozoraKit.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/katklian'

  s.platform = :ios, '15.0'
  s.ios.deployment_target = '15.0'

  s.source_files = 'KurozoraKit/Classes/**/*'
  s.swift_version = '5.0'

  s.dependency 'KeychainAccess'
  s.dependency 'TRON'
end
