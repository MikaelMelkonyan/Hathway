//
//  AppState.swift
//  Hathway
//
//  Created by Mikael Melkonyan on 27.03.2021.
//

struct AppState {
    private(set) var items = ItemsState()
    private(set) var randomItem = RandomItemState.loading
}

// MARK: - Reducible
extension AppState: Reducible {
    mutating func reduce(_ action: Actionable) {
        items.reduce(action)
        randomItem.reduce(action)
    }
}
