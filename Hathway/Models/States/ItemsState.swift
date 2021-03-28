//
//  ItemsState.swift
//  Hathway
//
//  Created by Mikael Melkonyan on 28.03.2021.
//

struct ItemsState: StringIdentifiable {
    private(set) var items = [Beer]()
    private(set) var favorites = Set<Int>()
    
    private(set) var allState = AllState.loading
    private(set) var favoritesState = FavoritesState.loading
    
    var id: String { String(describing: Self.self) }
}

// MARK: - Reducible
extension ItemsState: Reducible {
    mutating func reduce(_ action: Actionable) {
        switch action {
        case let action as Actions.LoadPage where action.id == AllMiddleware.id:
            allState = .loading
            favoritesState = .loading
        case let action as Actions.DidGetError where action.id == AllMiddleware.id:
            allState = .loaded(.failure(action.error.description))
            favoritesState = .loaded(.failure(action.error.description))
        case let action as Actions.DidLoadItems<Beer> where action.id == AllMiddleware.id:
            items = action.items
            updateStates()
        case let action as Actions.AddToFavorites where action.collectionID == Self.id:
            favorites.insert(action.id)
            updateStates()
        case let action as Actions.RemoveFromFavorites where action.collectionID == Self.id:
            favorites.remove(action.id)
            updateStates()
        default:
            break
        }
    }
}

// MARK: - Private
private extension ItemsState {
    mutating func updateStates() {
        allState = .loaded(.success(items.map({
            let isFavorite = favorites.contains($0.id)
            return ($0, isFavorite)
        })))
        favoritesState = favoritesSuccessState
    }
    
    var favoritesSuccessState: FavoritesState {
        let items = self.items.filter { favorites.contains($0.id) }
        if !items.isEmpty {
            return .loaded(.success(items))
        }
        return .loaded(.failure("No favorites yet"))
    }
}
