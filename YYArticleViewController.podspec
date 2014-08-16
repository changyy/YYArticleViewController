Pod::Spec.new do |s|
  s.name     = 'YYArticleViewController'
  s.version  = '1.0'
  s.license  = { :type => 'BSD'}
  s.summary  = 'A Float UIView for iOS.'
  s.homepage = 'https://github.com/changyy/YYArticleViewController'
  s.authors  = 'Yuan-Yi Chang', 
  s.source   = { :git => 'https://github.com/changyy/YYArticleViewController.git',
                 :tag => "#{s.version}" }
  s.description = ''
  s.source_files = '{YYArticleViewController}/*.{h,m}'
  s.requires_arc = true
  s.ios.deployment_target = '4.0'
end
