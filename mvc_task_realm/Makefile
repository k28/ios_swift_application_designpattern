
build:
	#swift build -Xswiftc -sdk -Xswiftc /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS13.0.sdk -Xswiftc -target -Xswiftc arm64-apple-ios13.0
	swift build -Xswiftc -sdk -Xswiftc `xcrun --sdk iphonesimulator --show-sdk-path` -Xswiftc -target -Xswiftc "x86_64-apple-ios13-simulator"

all:build

clean:
	rm -fr ./.build


