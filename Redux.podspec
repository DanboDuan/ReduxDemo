Pod::Spec.new do |s|
  s.name             = 'Redux'
  s.version          = '1.3.0'
  s.summary          = 'Redux in Objective-C'
  s.description      = 'Redux'

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
