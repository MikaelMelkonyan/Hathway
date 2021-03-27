//
//  TabsComponent.swift
//  Hathway
//
//  Created by Mikael Melkonyan on 27.03.2021.
//

import SwiftUI

struct TabsComponent<All: Container, Random: Container, Favorites: Container>: Component {
    let properties: Properties
    
    var body: some View {
        TabView {
            properties.all()
                .tabItem { Label("All", systemImage: "square.grid.2x2") }
            properties.random()
                .tabItem { Label("Random", systemImage: "shuffle") }
            properties.favorites()
                .tabItem { Label("Favorites", systemImage: "heart") }
        }
    }
}

extension TabsComponent {
    struct Properties {
        var all: () -> All
        var random: () -> Random
        var favorites: () -> Favorites
    }
}

// MARK: - Previews
struct TabsComponent_Previews: PreviewProvider {
    static var previews: some View {
        TabsComponent(properties: .init(
            all: { RenderContainer(view: AllComponent_Previews.previews) },
            random: { RenderContainer(view: RandomComponent_Previews.previews) },
            favorites: { RenderContainer(view: FavoritesComponent_Previews.previews) }
        ))
    }
}
