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
                    image
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
        .navigationBarTitle(Text(properties.isRandom ? "Random" : properties.beer.name), displayMode: .inline)
        .navigationBarItems(trailing: navigationButton)
    }
}

// MARK: - Private
private extension DetailsComponent {
    @ViewBuilder
    var navigationButton: some View {
        if properties.isRandom {
            randomizeButton
        } else {
            likeButton
        }
    }
    
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
    
    var randomizeButton: some View {
        Button(action: {
            properties.getAnother()
        }, label: {
            Image(systemName: "shuffle")
        })
    }
    
    @ViewBuilder
    var image: some View {
        if let url = properties.beer.imageURL {
            ImageView(withURL: url)
        } else {
            Group {}
        }
    }
}

// MARK: - Model
extension DetailsComponent {
    struct Properties {
        let beer: Beer
        let isFavorite: Bool
        let isRandom: Bool
        
        var addToFavorites: Command
        var removeFromFavorites: Command
        var getAnother: Command
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
            isFavorite: true, isRandom: false,
            addToFavorites: {}, removeFromFavorites: {}, getAnother: {}
        ))
    }
}

