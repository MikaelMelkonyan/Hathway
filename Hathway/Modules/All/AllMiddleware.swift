//
//  AllMiddleware.swift
//  Hathway
//
//  Created by Mikael Melkonyan on 27.03.2021.
//

final class AllMiddleware: Middleware<AppState>, StringIdentifiable {
    private lazy var beersApi = BeersApi()
    
    override func sink(action: Actionable) {
        switch action {
        case _ as Actions.AppLaunched:
            sink(action: Actions.LoadPage(id: Self.id))
        case let action as Actions.LoadPage where action.id == Self.id:
            queue.async {
                self.beersApi.beers(page: action.pageNumber) { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case let .success(beers):
                        self.store.dispatch(action: Actions.DidLoadItems(items: beers, id: Self.id))
                    case let .failure(error):
                        self.store.dispatch(action: Actions.DidGetError(error: error, id: Self.id))
                    }
                }
            }
        default:
            break
        }
    }
}
