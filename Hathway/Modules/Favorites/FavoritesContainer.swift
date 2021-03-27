//
//  FavoritesContainer.swift
//  Hathway
//
//  Created by Mikael Melkonyan on 27.03.2021.
//

struct FavoritesContainer: Container {
    typealias ContainerComponent = FavoritesComponent
    
    func properties(store: AppEnvironmentStore) -> ContainerComponent.Properties {
        .init()
    }
}
