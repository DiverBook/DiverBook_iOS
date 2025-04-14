import Foundation
import ProjectDescription

let project = Project(
    name: "DiverBook_iOS",
    targets: [
        .target(
            name: "DiverBook_iOS",
            destinations: .iOS,
            product: .app,
            bundleId: "ada.divercity.DiverBook-iOS",
            infoPlist: .extendingDefault(
                with: [
                    "CFBundleShortVersionString": "1.0.0", // 앱 버전
                    "CFBundleVersion": "1", // 빌드 버전
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                    "UIUserInterfaceStyle": "Light",
                    "UISupportedInterfaceOrientations": [
                        "UIInterfaceOrientationPortrait",
                    ],
                ]
            ),
            sources: ["DiverBook_iOS/Sources/**"],
            resources: ["DiverBook_iOS/Resources/**"],
            scripts: [
                .pre(
                    script: """
                    export PATH="$PATH:/opt/homebrew/bin"
                    if which swiftlint >/dev/null; then
                        swiftlint
                    else
                        echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
                    fi
                    """,
                    name: "SwiftLint",
                    basedOnDependencyAnalysis: false
                )
            ],
            dependencies: [
                
            ],
            additionalFiles: [".swiftlint.yml"]
        ),
        .target(
            name: "DiverBook_iOSTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.DiverBook-iOSTests",
            infoPlist: .default,
            sources: ["DiverBook_iOS/Tests/**"],
            resources: [],
            dependencies: [.target(name: "DiverBook_iOS")]
        ),
    ]
)
