Pod::Spec.new do |s|
  s.name         = "ASPolylineView"
  s.version      = "1.0.1"
  s.summary      = "Drop-in replacement for MKPolylineRenderer and MKPolylineView with more customisation options."
  s.description  = <<-DESC
                    Currently it is simple and only includes drawing a differently coloured border around the line. See header files for options.
                   DESC
  s.homepage     = "https://github.com/nighthawk/ASPolylineView"
  s.license      = 'FreeBSD'
  s.author       = { "Adrian Schoenig" => "adrian.schoenig@gmail.com" }
  s.source       = { :git => "https://github.com/nighthawk/ASPolylineView.git", :tag => "v#{s.version}" }
  s.framework    = 'MapKit'
  s.requires_arc = true

  s.ios.deployment_target = '5.0'
  s.osx.deployment_target = '10.9'

  s.ios.source_files = '*.{h,m}'
  s.osx.source_files = 'ASPolylineRenderer.{h,m}'
end
