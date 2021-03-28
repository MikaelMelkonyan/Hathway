//
//  DetailsContainer.swift
//  Hathway
//
//  Created by Mikael Melkonyan on 28.03.2021.
//

struct DetailsContainer: Container {
    typealias ContainerComponent = DetailsComponent
    let beer: Beer
    
    func properties(store: AppEnvironmentStore) -> ContainerComponent.Properties {
        let isFavorite = store.state.items.favorites.contains(beer.id)
        return .init(beer: beer, isFavorite: isFavorite, addToFavorites: {
            store.dispatch(Actions.AddToFavorites(collectionID: ItemsState.id, id: beer.id))
        }, removeFromFavorites: {
            store.dispatch(Actions.RemoveFromFavorites(collectionID: ItemsState.id, id: beer.id))
        })
    }
}

