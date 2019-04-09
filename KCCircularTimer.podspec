Pod::Spec.new do |s|
  s.name             = 'KCCircularTimer'
  s.version          = '0.1.2'
  s.summary          = 'A simple circular timer usable with Interface Builder in Xcode.'
  s.description      = <<-DESC
KCCircularTimer is a simple, configurable circular timer that is usable in Interface Builder in Xcode.
                       DESC

  s.homepage         = 'https://github.com/kcramer/KCCircularTimer'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Kevin Cramer' => 'kevinx@sent.com' }
  s.source           = { :git => 'https://github.com/kcramer/KCCircularTimer.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'Sources/**/*.swift'
end
