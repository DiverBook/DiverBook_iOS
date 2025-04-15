import SwiftUI

@main
struct DiverBookIOSApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject var coordinator: Coordinator = Coordinator()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: self.$coordinator.path) {
                OnboardingView()
                    .navigationDestination(for: Path.self, destination: { path in
                        switch path {
                        case .splash:
                            OnboardingView()
                                .toolbar(.hidden, for: .navigationBar)
                        case .mainTab:
                            DiverBookTabView(viewModel: DiverBookTabViewModel(coordinator: self.coordinator))
                                .toolbar(.hidden, for: .navigationBar)
                        }
                    })
            }
        }
    }
}
