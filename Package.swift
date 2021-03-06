// swift-tools-version:5.3.0

import PackageDescription

let package = Package(
    name: "CoreUI",
    platforms: [
        .iOS("15")
    ],
    products: [
        .library(
            name: "CoreUI",
            targets: [
                "CoreUI"
            ]
        )
    ],
    dependencies: [
        .package(name: "Core", url: "https://github.com/kutchie-pelaez-packages/Core.git", .branch("master")),
        .package(name: "SnapKit", url: "https://github.com/kutchie-pelaez-packages/SnapKit.git", .branch("master"))
    ],
    targets: [
        .target(
            name: "CoreUI",
            dependencies: [
                .product(name: "Core", package: "Core"),
                .product(name: "SnapKit", package: "SnapKit")
            ],
            path: "Sources"
        )
    ]
)
