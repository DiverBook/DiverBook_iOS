//
//  ProfileAsyncImage.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 5/4/25.
//

import Foundation
import SwiftUI

struct ProfileImageView: View {
    let imageURL: URL?
    let style: ProfileStyle
    let placeholderImageName: String
    
    var body: some View {
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
                    Image(systemName: placeholderImageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: style.imageSize, height: style.imageSize)
                        .clipShape(Circle())
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }
            }
        } else {
            Image(placeholderImageName)
                .resizable()
                .scaledToFit()
                .frame(width: style.imageSize, height: style.imageSize)
                .clipShape(Circle())
        }
    }
}
