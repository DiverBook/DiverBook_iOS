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
                    "NSCameraUsageDescription": "러너 출입증 인식을 위해 카메라 접근 권한이 필요합니다.",
                    "NSNearbyInteractionUsageDescription": "근처 기기와 상호작용하기 위해 NearbyInteraction을 사용합니다.",
                    "NSLocalNetworkUsageDescription": "기기 간 통신을 위해 로컬 네트워크 사용 권한이 필요합니다.",
                    "NSBluetoothAlwaysUsageDescription": "기기 간 탐색을 위해 블루투스 사용 권한이 필요합니다.",
                    "NSBonjourServices": [
                        "_DiverBook._udp",
                        "_DiverBook._tcp"
                    ]
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
                .external(name: "Lottie"),
                .external(name: "Kingfisher")
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
