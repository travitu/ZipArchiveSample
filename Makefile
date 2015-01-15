test:
    xcodebuild \
        -project SSZipArchiveSample.xcodeproj \
        -sdk iphonesimulator \
        -scheme SSZipArchiveSample \
        -configuration Debug \
        -destination 'platform=iOS Simulator,name=iPhone 6,0S=8.1' \
        clean build test