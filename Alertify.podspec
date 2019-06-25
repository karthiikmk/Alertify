
Pod::Spec.new do |s|
  s.name             = 'Alertify'
  s.version          = '4.0.5'
  s.swift_version    = '4.2'
  s.summary          = 'A Eligant and Simple sugar for ActionSheet and AlertController.'
  s.homepage         = 'https://github.com/karthikAdaptavant/Alertify'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'karthikAdaptavant' => 'karthik.samy@a-cti.com' }
  s.social_media_url = 'https://twitter.com/i_am_kaarthik'
  s.source           = { :git => 'https://github.com/karthikAdaptavant/Alertify.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  s.source_files = 'Alertify/Classes/**/*'
end

# install fastlane in project root folder
# that will create gem file (add things needed)
# https://mar.codes/2018-11-14/Automate-open-source-libraries-releases-with-fastlane?fbclid=IwAR0_4N0ailvFLt--2mtPz3bhUzcC81PZD3cWSkljcp1J2wzlpoteGV-4O4s
# edit fast file to add lane
# push the pod
