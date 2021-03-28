//
//  RandomMiddleware.swift
//  Hathway
//
//  Created by Mikael Melkonyan on 28.03.2021.
//

final class RandomMiddleware: Middleware<AppState>, StringIdentifiable {
    private lazy var beersApi = BeersApi()
    
    override func sink(action: Actionable) {
        switch action {
        case _ as Actions.AppLaunched:
            sink(action: Actions.LoadRandomBeer(id: Self.id))
        case let action as Actions.LoadRandomBeer where action.id == Self.id:
            queue.async {
                self.beersApi.random { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case let .success(beers):
                        guard let beer = beers.first else {
                            self.store.dispatch(action: Actions.DidGetError(
                                error: Api.Error(statusCode: nil, description: "Error while getting random beer"),
                                id: Self.id
                            ))
                            return
                        }
                        self.store.dispatch(action: Actions.DidLoadItem(item: beer, id: Self.id))
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
