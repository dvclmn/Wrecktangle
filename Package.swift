// swift-tools-version:5.6

import PackageDescription

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
    .package(name: "Helpers", path: "../Helpers"),
  ],
  targets: [
    .target(name: "SwiftBox", dependencies: ["Helpers"]),

    .testTarget(
      name: "SwiftBoxTests", dependencies: ["SwiftBox"]
    )
    
  ]
)
