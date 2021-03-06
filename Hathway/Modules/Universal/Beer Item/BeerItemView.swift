//
//  BeerItemView.swift
//  Hathway
//
//  Created by Mikael Melkonyan on 28.03.2021.
//

import SwiftUI

struct BeerItemView: Component {
    let properties: Properties
    
    var body: some View {
        HStack {
            HStack(spacing: 16) {
                image
                    .frame(width: 80, height: 80)
                
                Text(properties.name)
            }
            
            Spacer()
            
            Image(systemName: properties.isFavorite ? "star.fill" : "star")
        }
    }
}

// MARK: - Private
private extension BeerItemView {
    @ViewBuilder
    var image: some View {
        if let url = properties.imageURL {
            ImageView(withURL: url)
        } else {
            Group {}
        }
    }
}

// MARK: - Model
extension BeerItemView {
    struct Properties {
        let name: String
        let imageURL: String?
        let isFavorite: Bool
    }
}

// MARK: - Previews
struct BeerItemView_Previews: PreviewProvider {
    static var previews: some View {
        BeerItemView(properties: .init(
            name: "Test", imageURL: "https://images.punkapi.com/v2/keg.png", isFavorite: true
        ))
    }
}
