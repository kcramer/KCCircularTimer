// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "KCCircularTimer",
    platforms: [
        .macOS(.v10_14), .iOS(.v8), .watchOS(.v3), .tvOS(.v10)
    ],
    products: [
        .library(
            name: "KCCircularTimer",
            targets: ["KCCircularTimer"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "KCCircularTimer",
            dependencies: [],
            path: "KCCircularTimer"
        ),
        .testTarget(
            name: "Tests",
            dependencies: ["KCCircularTimer", "SnapshotTesting"],
            path: "Tests"
        )
    ]
)
