// swift-tools-version:5.6

import PackageDescription

let localPackagesRoot = "/Users/dvclmn/Apps/_ Swift Packages"

let package = Package(
  name: "SwiftBox",
  platforms: [
    .iOS("17.0"),
    .macOS("14.0")
  ],
  products: [
    .library(
      name: "SwiftBox",
      targets: [
        "SwiftBox"
      ]
    )
  ],
  dependencies: [
    .package(name: "Helpers", path: "\(localPackagesRoot)/SwiftCollection/Helpers"),
    .package(name: "TextCore", path: "\(localPackagesRoot)/TextCore"),
    .package(name: "Styles", path: "\(localPackagesRoot)/Styles"),
    .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),

  ],
  targets: [
    .target(name: "SwiftBox", dependencies: ["TextCore", "Helpers", "Styles"]),
    .testTarget(
      name: "SwiftBoxTests", dependencies: ["SwiftBox"]
    ),
  ]
)
