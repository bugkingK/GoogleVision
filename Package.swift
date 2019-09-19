import PackageDescription

let package = Package(
    name: "GoogleVision",
    products: [
        .library(
            name: "GoogleVision",
            targets: ["GoogleVision"]),
    ],
    targets: [
        .target(
            name: "GoogleVision",
            path: "GoogleVision/Source"),
    ]
)
