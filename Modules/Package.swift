// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [.macOS(.v13), .iOS(.v17)],
    products: [
        .library(name: "AppFeature", targets: ["AppFeature"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.17.0"),
        .package(url: "https://gitlab.com/krr-tca/tca-utils", from: "3.0.0"),
    ],
    targets: [
        .target(name: "AppFeature", dependencies: [
            .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            .product(name: "ReusableComponents", package: "tca-utils"),
        ]),
    ]
)
