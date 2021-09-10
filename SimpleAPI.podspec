
Pod::Spec.new do |spec|


  spec.name         = "SimpleAPI"
  spec.version      = "0.0.1"
  spec.summary      = "Simple HTTP Networking in Swift"


  spec.description  = <<-DESC
    Simple HTTP Networking in Swift based on UrlSession
                   DESC

  spec.homepage     = "https://github.com/belalsamyyy/SimpleAPI"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Belal Samy" => "belalsamy10@gmail.com" }
  
  spec.ios.deployment_target = "14.5"
  spec.swift_version = "5"
  
  spec.source       = { :git => "https://github.com/belalsamyyy/SimpleAPI.git", :tag => "#{spec.version}" }
  spec.source_files  = "SimpleAPI/**/*.{h,m,swift}"

end
