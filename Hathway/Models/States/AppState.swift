//
//  AppState.swift
//  Hathway
//
//  Created by Mikael Melkonyan on 27.03.2021.
//

struct AppState {
    
    private(set) var allState = AllState.none
}

// MARK: - Reducible
extension AppState: Reducible {
    mutating func reduce(_ action: Actionable) {
        allState.reduce(action)
    }
}

