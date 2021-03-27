//
//  TabsContainer.swift
//  Hathway
//
//  Created by Mikael Melkonyan on 27.03.2021.
//

struct TabsContainer: Container {
    typealias ContainerComponent = TabsComponent<AllContainer, RandomContainer, FavoritesContainer>
    
    func properties(store: AppEnvironmentStore) -> ContainerComponent.Properties {
        .init {
            AllContainer()
        } random: {
            RandomContainer()
        } favorites: {
            FavoritesContainer()
        }
    }
}
