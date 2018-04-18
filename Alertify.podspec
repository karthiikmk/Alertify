
Pod::Spec.new do |s|
  s.name             = 'Alertify'
  s.version          = '4.0'
  s.summary          = 'A Eligant and Simple sugar for ActionSheet and AlertController.'
  s.homepage         = 'https://github.com/karthikAdaptavant/Alertify'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'karthikAdaptavant' => 'karthik.samy@a-cti.com' }
  s.source           = { :git => 'https://github.com/karthikAdaptavant/Alertify.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  s.source_files = 'Alertify/Classes/**/*'
end
 
