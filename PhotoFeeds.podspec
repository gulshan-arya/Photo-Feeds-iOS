Pod::Spec.new do |spec|
  spec.name         = "PhotoFeeds"
  spec.version      = "1.0.0"
  spec.summary      = "A small framework to load infinite scroll wise images from the backend server."
  spec.description  = <<-DESC
                    PhotoFeeds provides you with smooth loading of images from the server in a MVVM architecture. It uses a third party library to fetch images!
                   DESC
  spec.homepage     = "https://github.com/gulshan-arya/Photo-Feeds-iOS"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Gulshan Kumar" => "singh.aryan7575@gmail.com" }
  spec.platform     = :ios, "12.0"
  spec.source       = { :git => "https://github.com/gulshan-arya/Photo-Feeds-iOS.git", :tag => "#{spec.version}" }
  spec.source_files = "PhotoFeeds/PhotoFeeds/*"
  spec.swift_version = "4.0"
end