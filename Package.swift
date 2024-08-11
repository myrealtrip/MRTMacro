// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "MRTMacro",
    platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6), .macCatalyst(.v13)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "MRTMacro",
            targets: ["MRTMacro"]
        ),
        .executable(
            name: "MRTMacroClient",
            targets: ["MRTMacroClient"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-syntax.git", from: "509.0.0"),
        
        /// 1.2.0 버전 이상부턴 tuist 와 호환되지 않는 이슈가 있음
        /// https://github.com/tuist/tuist/issues/6579
        .package(url: "https://github.com/SwiftyLab/MetaCodable.git", exact: "1.1.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        // Macro implementation that performs the source transformation of a macro.
        .macro(
            name: "MRTMacroTypes",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
            ]
        ),

        // Library that exposes a macro as part of its API, which is used in client programs.
        .target(
            name: "MRTMacro",
            dependencies: [
                "MRTMacroTypes",
                .product(name: "MetaCodable", package: "MetaCodable")
            ]
        ),

        // A client of the library, which is able to use the macro in its own code.
        .executableTarget(
            name: "MRTMacroClient",
            dependencies: ["MRTMacro"]
        ),

        // A test target used to develop the macro implementation.
        .testTarget(
            name: "MRTMacroTests",
            dependencies: [
                "MRTMacroTypes",
                .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
            ]
        ),
    ]
)
