//
//  ProfileAsyncImage.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 5/4/25.
//

import Foundation
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
        if let imageURL = imageURL {
            AsyncImage(url: imageURL) { phase in
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
                    placeholderImage
                @unknown default:
                    placeholderImage
                }
            }
        } else {
            placeholderImage
        }
    }
    
    @ViewBuilder
    private var kingfisherImageView: some View {
        if let imageURL = imageURL {
            KFImage(imageURL)
                .placeholder {
                    Image(placeholderImageName)
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                }
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
        } else {
            placeholderImage
        }
    }
    
    private var placeholderImage: some View {
        Image(placeholderImageName)
            .resizable()
            .scaledToFit()
            .frame(width: style.imageSize, height: style.imageSize)
            .clipShape(Circle())
    }
}
