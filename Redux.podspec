#
# Be sure to run `pod lib lint BDAutoTracker.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Redux'
  s.version          = '1.3.0'
  s.summary          = 'Redux in Objective-C'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/DanboDuan/ReduxDemo'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'bob' => 'bob170131@gmail.com' }
  s.source           = { :git => 'https://github.com/DanboDuan/ReduxDemo.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.default_subspec = 'Core','Thunk','Reduce','Combine','Schedule'
  s.frameworks = 'Foundation'


  s.subspec 'Utility' do |utility|
        utility.source_files = 'Redux/Utility/**/*.{h,m}'
  end
  
  s.subspec 'Core' do |c|
        c.source_files = 'Redux/CoreTypes/**/*.{h,m}'
        c.public_header_files = 'Redux/CoreTypes/*.h'
        c.dependency 'Redux/Utility'
  end

  s.subspec 'Thunk' do |thunk|
        thunk.source_files = 'Redux/Thunk/**/*.{h,m}'
        thunk.public_header_files = 'Redux/Thunk/*.h'
        thunk.dependency 'Redux/Core'
  end

  s.subspec 'Reduce' do |reduce|
        reduce.source_files = 'Redux/ReduceReducers/**/*.{h,m}'
        reduce.public_header_files = 'Redux/ReduceReducers/*.h'
        reduce.dependency 'Redux/Core'
  end

  s.subspec 'Combine' do |combine|
        combine.source_files = 'Redux/CombineReducers/**/*.{h,m}'
        combine.public_header_files = 'Redux/CombineReducers/*.h'
        combine.dependency 'Redux/Core'
  end

  s.subspec 'Schedule' do |schedule|
      schedule.source_files = 'Redux/Schedule/**/*.{h,m}'
      schedule.public_header_files = 'Redux/Schedule/*.h'
      schedule.dependency 'Redux/Core'
  end

end
