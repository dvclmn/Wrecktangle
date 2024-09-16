// swift-tools-version:5.10

import PackageDescription

let localPackagesRoot = "/Users/dvclmn/Apps/_ Swift Packages"

let package = Package(
  name: "SwiftBox",
  platforms: [
    .iOS("16.0"),
    .macOS("12.0")
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
    .package(url: "https://github.com/mattmassicotte/nsui", from: "1.3.0"),
    .package(url: "https://github.com/dvclmn/TextCore.git", branch: "main"),
    .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),

  ],
  targets: [
    .target(name: "SwiftBox", dependencies: ["TextCore", .product(name: "NSUI", package: "nsui")]),
    .testTarget(
      name: "SwiftBoxTests", dependencies: ["SwiftBox"]
    ),
  ]
)

let swiftSettings: [SwiftSetting] = [
  .enableExperimentalFeature("StrictConcurrency"),
  .enableUpcomingFeature("DisableOutwardActorInference"),
]

for target in package.targets {
  var settings = target.swiftSettings ?? []
  settings.append(contentsOf: swiftSettings)
  target.swiftSettings = settings
}
