
Pod::Spec.new do |spec|


  spec.name         = "SimpleAPI"
  spec.version      = "2.0.3"
  spec.summary      = "Simple HTTP Networking in Swift based on UrlSession"


  spec.description  = <<-DESC
    Simple and generic HTTP Networking in Swift based on UrlSession, you don't need to create an API Manager anymore, it's just work !
                   DESC

  spec.homepage     = "https://github.com/belalsamyyy/SimpleAPI"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Belal Samy" => "belalsamy10@gmail.com" }
  
  spec.ios.deployment_target = "13.0"
  spec.swift_version = "5"
  
  spec.source       = { :git => "https://github.com/belalsamyyy/SimpleAPI.git", :tag => "#{spec.version}" }
  spec.source_files  = "SimpleAPI/**/*.{h,m,swift}"

end
