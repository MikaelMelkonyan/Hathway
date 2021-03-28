//
//  RandomItemState.swift
//  Hathway
//
//  Created by Mikael Melkonyan on 28.03.2021.
//

typealias RandomItemState = ResponseState<Beer, String>

// MARK: - Reducible
extension RandomItemState: Reducible {
    mutating func reduce(_ action: Actionable) {
        switch action {
        case let action as Actions.DidGetError where action.id == RandomMiddleware.id:
            self = .loaded(.failure(action.error.description))
        case let action as Actions.DidLoadItem<Beer> where action.id == RandomMiddleware.id:
            self = .loaded(.success(action.item))
        case _ as Actions.LoadRandomBeer:
            self = .loading
        default:
            break
        }
    }
}
