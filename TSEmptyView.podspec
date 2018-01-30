

Pod::Spec.new do |s|
  s.name             = 'TSEmptyView'
  s.version          = '0.0.5.1'
  s.summary          = 'EmptyView for UIScrollView(UITableView,UICollectionView).'


  s.description      = <<-DESC
TSEmptyView for UIScrollView(UITableView,UICollectionView),you can customize the view
                       DESC

  s.homepage         = 'https://github.com/leetangsong/TSEmptyView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'leetangsong' => 'leetangsong@icloud.com' }
  s.source           = { :git => 'https://github.com/leetangsong/TSEmptyView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'TSEmptyView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'TSEmptyView' => ['TSEmptyView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
