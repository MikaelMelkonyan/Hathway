//
//  RandomComponent.swift
//  Hathway
//
//  Created by Mikael Melkonyan on 27.03.2021.
//

import SwiftUI

struct RandomComponent<Loading: Container, Message: Container, Details: Container>: Component {
    let properties: Properties
    
    var body: some View {
        NavigationView {
            switch properties.state {
            case .none, .loading:
                properties.loading()
                    .navigationBarTitle(Text("Random"), displayMode: .inline)
            case let .loaded(result):
                switch result {
                case let .success(beer):
                    properties.details(beer)
                        .navigationBarTitle(Text("Random"), displayMode: .inline)
                case let .failure(error):
                    properties.message(error.description)
                        .navigationBarTitle(Text("Random"), displayMode: .inline)
                }
            }
        }
    }
}

extension RandomComponent {
    struct Properties {
        let state: RandomItemState
        
        var loading: () -> Loading
        var message: (String) -> Message
        var details: (Beer) -> Details
    }
}

// MARK: - Previews
struct RandomComponent_Previews: PreviewProvider {
    static var previews: some View {
        RandomComponent(properties: .init(
            state: .loading,
            loading: { RenderContainer(view: LoadingComponent_Previews.previews) },
            message: { _ in RenderContainer(view: MessageComponent_Previews.previews) },
            details: { _ in RenderContainer(view: DetailsComponent_Previews.previews) }
        ))
    }
}
