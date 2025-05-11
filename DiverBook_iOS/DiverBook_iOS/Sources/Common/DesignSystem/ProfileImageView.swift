import Kingfisher
import SwiftUI

enum ImageLoadingMethod {
    case asyncImage
    case kingfisher
}

struct ProfileImageView: View {
    let imageURL: URL?
    let style: ProfileStyle
    let placeholderImageName: String
    let loadingMethod: ImageLoadingMethod

    var body: some View {
        switch loadingMethod {
        case .asyncImage:
            asyncImageView
        case .kingfisher:
            kingfisherImageView
        }
    }
    
    @ViewBuilder
    private var asyncImageView: some View {
        if let url = imageURL {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: style.imageSize, height: style.imageSize)
                        .clipShape(Circle())
                case .failure:
                    placeholderImageView
                @unknown default:
                    placeholderImageView
                }
            }
        } else {
            placeholderImageView
        }
    }

    @ViewBuilder
    private var kingfisherImageView: some View {
        if let url = imageURL {
            KFImage(url)
                .placeholder {
                    placeholderImageView
                }
                .resizable()
                .scaledToFit()
                .frame(width: style.imageSize, height: style.imageSize)
                .clipShape(Circle())
        } else {
            placeholderImageView
        }
    }

    private var placeholderImageView: some View {
        Image(placeholderImageName)
            .resizable()
            .scaledToFill()
            .frame(width: style.imageSize, height: style.imageSize)
            .clipShape(Circle())
    }
}
