Pod::Spec.new do |s|

  s.name         = "GoogleVision"
  s.version      = "1.0.0"
  s.summary      = "Cloud Vision API allows developers to easily integrate vision detection features within applications"
  s.description  = <<-DESC
Cloud Vision API allows developers to easily integrate vision detection features within applications, including image labeling, face and landmark detection, optical character recognition (OCR), and tagging of explicit content.
                   DESC

  s.homepage     = "https://github.com/bugkingK/GoogleVision"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "bugkingK" => "myway0710@naver.com" }
  s.platform     = :ios, "10.0"
  s.source       = { :git => "https://github.com/bugkingK/GoogleVision.git", :tag => "#{s.version}" }
  s.source_files = "Classes", "GoogleVision/Source/**/*.{swift}"

  s.dependency 'SwiftyJSON'

  s.swift_version = '5.0'	

end
