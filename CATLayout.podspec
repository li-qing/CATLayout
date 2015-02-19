Pod::Spec.new do |s|

  s.name          = "CATLayout"
  s.summary       = "Objective-C Auto Layout Constraint Builder with Chaining Pattern"
  s.description   = <<-DESC

                  we will never like the codes below :

                    [NSLayoutConstraint constraintWithItem:fromItem
                                                 attribute:fromAttribute
                                                 relatedBy:relation
                                                    toItem:toItem
                                                 attribute:toAttribute
                                                multiplier:multiplier
                                                  constant:constant]

                  why not make it simple & clear like this :

                    syntax: <#from attribute#>.<#relation#>.<#multiplier#>.<#to attribute of view#>.<#constant#>

                    example: view.cat_layout.width.equal.multiply(0.5f).widthOf(container).constant(8)
                    
                   DESC

  s.homepage      = "https://github.com/li-qing/CATLayout"
  s.author        = { "li-qing" => "lshhch@gmail.com" }
  s.license       = "MIT"

  s.version       = "1.0.0"
  s.platform      = :ios, "6.0"
  s.requires_arc  = true
  s.frameworks    = 'Foundation', 'UIKit' 
  s.source        = { :git => "https://github.com/li-qing/CATLayout.git", :tag => s.version.to_s }
  s.source_files  = "CATLayout/*.{h,m}"

end
