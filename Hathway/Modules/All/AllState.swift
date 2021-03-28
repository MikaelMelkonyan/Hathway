//
//  AllState.swift
//  Hathway
//
//  Created by Mikael Melkonyan on 28.03.2021.
//

typealias AllState = ResponseState<[Beer], Api.Error>

// MARK: - Reducible
extension AllState: Reducible {
    mutating func reduce(_ action: Actionable) {
        switch action {
        case let action as Actions.LoadPage where action.id == AllMiddleware.id:
            self = .loading
        case let action as Actions.DidGetError where action.id == AllMiddleware.id:
            self = .loaded(.failure(action.error))
        case let action as Actions.DidLoadItems<Beer> where action.id == AllMiddleware.id:
            self = .loaded(.success(action.items))
        default:
            break
        }
    }
}
