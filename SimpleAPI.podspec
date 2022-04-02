
Pod::Spec.new do |spec|


  spec.name         = "SimpleAPI"
  spec.version      = "2.0.7"
  spec.summary      = "Simple HTTP Networking in Swift based on UrlSession"


  spec.description  = <<-DESC
      Simple HTTP Networking in Swift based on UrlSession, trying to make networking simple and easy
                   DESC

  spec.homepage     = "https://github.com/belalsamyyy/SimpleAPI"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Belal Samy" => "belalsamy10@gmail.com" }
  
  spec.ios.deployment_target = "13.0"
  spec.swift_version = "5"
  
  spec.source       = { :git => "https://github.com/belalsamyyy/SimpleAPI.git", :tag => "#{spec.version}" }
  spec.source_files  = "SimpleAPI/**/*.{h,m,swift}"

end
