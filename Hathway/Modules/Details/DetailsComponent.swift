//
//  DetailsComponent.swift
//  Hathway
//
//  Created by Mikael Melkonyan on 28.03.2021.
//

import SwiftUI

struct DetailsComponent: Component {
    let properties: Properties
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 16) {
                    ImageView(withURL: properties.beer.imageURL)
                        .frame(width: geometry.size.width, height: geometry.size.width)
                    
                    HStack(spacing: 8) {
                        Text(properties.beer.name)
                            .font(.headline)
                        
                        Spacer()
                        
                        Text(properties.beer.firstBrewed)
                            .font(.caption2)
                    }
                    
                    Text(properties.beer.tagline)
                        .font(.subheadline)
                    
                    Text(properties.beer.description)
                    
                    Spacer()
                }
            }
        }
        .padding()
        .navigationBarTitle(Text(properties.beer.name), displayMode: .inline)
        .navigationBarItems(trailing: likeButton)
    }
}

// MARK: - Private
private extension DetailsComponent {
    var likeButton: some View {
        Button(action: {
            if properties.isFavorite {
                properties.removeFromFavorites()
            } else {
                properties.addToFavorites()
            }
        }, label: {
            Image(systemName: properties.isFavorite ? "star.fill" : "star")
        })
    }
}

// MARK: - Model
extension DetailsComponent {
    struct Properties {
        let beer: Beer
        let isFavorite: Bool
        
        var addToFavorites: Command
        var removeFromFavorites: Command
    }
}

// MARK: - Previews
struct DetailsComponent_Previews: PreviewProvider {
    static var previews: some View {
        DetailsComponent(properties: .init(
            beer: Beer(
                id: 0, name: "Name",
                tagline: "Tagline", description: "Description",
                firstBrewed: "02/2007", imageURL: ""
            ),
            isFavorite: true,
            addToFavorites: {},
            removeFromFavorites: {}
        ))
    }
}

