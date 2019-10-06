// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "mvc_task",
    platforms:[
        .iOS(.v12),
    ],
    targets: [
        .target(name: "mvc_task", path: "./mvc_task/Classes")
    ]
    )

