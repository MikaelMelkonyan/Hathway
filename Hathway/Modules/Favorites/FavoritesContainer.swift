//
//  FavoritesContainer.swift
//  Hathway
//
//  Created by Mikael Melkonyan on 27.03.2021.
//

struct FavoritesContainer: Container {
    typealias ContainerComponent = FavoritesComponent<LoadingContainer, MessageContainer, DetailsContainer>
    
    func properties(store: AppEnvironmentStore) -> ContainerComponent.Properties {
        .init(state: store.state.items.favoritesState) {
            LoadingContainer()
        } message: {
            MessageContainer(message: $0)
        } details: {
            DetailsContainer(beer: $0, isRandom: false)
        }
    }
}
