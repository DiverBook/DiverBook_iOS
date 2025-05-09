import SwiftUI

@main
struct DiverBookIOSApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    @StateObject var coordinator: Coordinator = Coordinator()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: self.$coordinator.path) {
                OnboardingView(coordinator: self.coordinator)
                    .toolbar(.hidden, for: .navigationBar)
                    .navigationDestination(
                        for: Path.self,
                        destination: { path in
                            switch path {
                            case .splash:
                                OnboardingView(coordinator: self.coordinator)
                                    .toolbar(.hidden, for: .navigationBar)
                            case .login(let nickname):
                                LoginView(
                                    nickname: nickname,
                                    coordinator: self.coordinator
                                )
                                    .toolbar(.hidden, for: .navigationBar)
                            case .userProfileSetting(let nickname):
                                UserProfileSettingView(
                                    nickName: nickname,
                                    coordinator: self.coordinator
                                )
                                    .toolbar(.hidden, for: .navigationBar)
                            case .idCardScan:
                                IDCardScannerView(coordinator: self.coordinator)
                                    .toolbar(.hidden, for: .navigationBar)
                            case .mainTab:
                                DiverBookTabView(coordinator: self.coordinator)
                                    .toolbar(.hidden, for: .navigationBar)
                                    .ignoresSafeArea(edges: [.vertical])
                                    .background(.white)
                            case .searchingDiver:
                                DiverSearchingView(coordinator: self.coordinator)
                                    .toolbar(.hidden, for: .navigationBar)
                            case .searchResult(diverProfile: let diverProfile):
                                DiverSearchResultView(
                                    diverProfile: diverProfile,
                                    coordinator: self.coordinator
                                )
                                    .toolbar(.hidden, for: .navigationBar)
                            case .startConversation:
                                ConversationView(coordinator: self.coordinator)
                                    .toolbar(.hidden, for: .navigationBar)
                            case .finishConversation:
                                //TODO: diverId 불러오기
                                DiverProfileView(coordinator: self.coordinator, diverId: "")
                            case .myProfile:
                                MyProfileView(coordinator: self.coordinator)
                                    .toolbar(.hidden, for: .navigationBar)
                            case .collectedBadge:
                                CollectedBadgeView()
                                    .toolbar(.hidden, for: .navigationBar)
                            case .unfoundDiver:
                                UnfoundDiverView(coordinator: coordinator)
                                    .toolbar(.hidden, for: .navigationBar)
                            case .diverProfile(let diverId):
                                DiverProfileView(coordinator: coordinator, diverId: diverId)
                                    .toolbar(.hidden, for: .navigationBar)
                            }
                        })
            }
        }
    }
}
