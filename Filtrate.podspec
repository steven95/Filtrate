   Pod::Spec.new do |s|
    
      s.name         = "Filtrate"

      s.version      = "0.0.1"

      s.summary      = "A short description of tcggMain."

      s.description  = "Good"
    
      s.homepage     = "https://github.com/steven95/"

      s.license      = "MIT"

      s.author             = { "Jusive" => "1345266022@qq.com" }

      s.source       = { :git => "https://github.com/steven95/Filtrate.git", :tag => "#{s.version}" }
 
      s.source_files  = "Utility"
      
      s.dependency 'Masonry,JXSegmentedView,SnapKit'

    end
