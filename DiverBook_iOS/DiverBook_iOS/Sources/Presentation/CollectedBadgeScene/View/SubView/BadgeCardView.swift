import SwiftUI

struct BadgeCardView: View {
    let badge: Badge
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 8) {
                if badge.isCollected, let url = URL(string: badge.imageUrl) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 62, height: 88)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 62, height: 88)
                        case .failure:
                            Image("lock")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 62, height: 88)
                        @unknown default:
                            EmptyView()
                                .frame(width: 62, height: 88)
                        }
                    }
                } else {
                    Image("lock")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 62, height: 88)
                }

                Text(badge.name)
                    .font(DiveFont.bodyMedium1)
                    .foregroundColor(
                        badge.isCollected ? DiveColor.black : DiveColor.gray3
                    )
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 150)
            .background(DiveColor.white)
            .cornerRadius(8)
            .modifier(BadgeCardModifier(isCollected: badge.isCollected))
        }
    }
}

struct BadgeCardModifier: ViewModifier {
    let isCollected: Bool

    func body(content: Content) -> some View {
        if isCollected {
            return content
                .applyShadow(DiveShadow.shadow1)
                .eraseToAnyView()
        } else {
            return content
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(DiveColor.stroke, lineWidth: 2)
                )
                .eraseToAnyView()
        }
    }
}

extension View {
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}
