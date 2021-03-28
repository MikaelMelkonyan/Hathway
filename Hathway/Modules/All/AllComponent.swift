//
//  AllComponent.swift
//  Hathway
//
//  Created by Mikael Melkonyan on 27.03.2021.
//

import SwiftUI

struct AllComponent<Loading: Container, Message: Container>: Component {
    let properties: Properties
    
    var body: some View {
        switch properties.state {
        case .none, .loading:
            properties.loading()
        case let .loaded(result):
            switch result {
            case let .success(beers):
                List(beers) { beer in
                    Text(beer.name)
                }
            case let .failure(error):
                properties.message(error.description)
            }
        }
    }
}

extension AllComponent {
    struct Properties {
        let state: AllState
        
        var loading: () -> Loading
        var message: (String) -> Message
    }
}

// MARK: - Previews
struct AllComponent_Previews: PreviewProvider {
    static var previews: some View {
        AllComponent(properties: .init(
            state: .loading,
            loading: { RenderContainer(view: LoadingComponent_Previews.previews) },
            message: { _ in RenderContainer(view: MessageComponent_Previews.previews) }
        ))
    }
}
