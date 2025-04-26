import SwiftUI

@main
struct DiverBookIOSApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    @StateObject var coordinator: Coordinator = Coordinator()

    var body: some Scene {
        WindowGroup {
            MyProfileView(viewModel: MyProfileViewModel())
//            NavigationStack(path: self.$coordinator.path) {
//                OnboardingView(coordinator: self.coordinator)
//                    .navigationDestination(
//                        for: Path.self,
//                        destination: { path in
//                            switch path {
//                            case .splash:
//                                OnboardingView(coordinator: self.coordinator)
//                                    .toolbar(.hidden, for: .navigationBar)
//                            case .userProfileSetting(let nickname):
//                                UserProfileSettingView(nickname: nickname, coordinator: self.coordinator)
//                                    .toolbar(.hidden, for: .navigationBar)
//                            case .idCardScan:
//                                IDCardScannerView(coordinator: self.coordinator)
//                                    .toolbar(.hidden, for: .navigationBar)
//                            case .mainTab:
//                                DiverBookTabView(coordinator: self.coordinator)
//                                    .toolbar(.hidden, for: .navigationBar)
//                            case .searchingDiver:
//                                DiverSearchingView(coordinator: self.coordinator)
//                                    .toolbar(.hidden, for: .navigationBar)
//                            case .searchResult(nickname: let nickname):
//                                DiverSearchResultView(nickname: nickname)
//                            }
//                        })
//            }
        }
    }
}
