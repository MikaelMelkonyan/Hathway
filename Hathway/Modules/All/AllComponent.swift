//
//  AllComponent.swift
//  Hathway
//
//  Created by Mikael Melkonyan on 27.03.2021.
//

import SwiftUI

struct AllComponent<Loading: Container, Message: Container, Details: Container>: Component {
    let properties: Properties
    
    var body: some View {
        NavigationView {
            switch properties.state {
            case .none, .loading:
                properties.loading()
                    .navigationBarTitle(Text("All"))
            case let .loaded(result):
                switch result {
                case let .success(beers):
                    List {
                        ForEach(beers, id: \.beer.id) { (beer, isFavorite) in
                            NavigationLink(destination: properties.details(beer)) {
                                BeerItemView(properties: .init(
                                    name: beer.name, imageURL: beer.imageURL, isFavorite: isFavorite
                                ))
                            }
                        }
                    }
                    .navigationBarTitle(Text("All"))
                case let .failure(error):
                    properties.message(error.description)
                        .navigationBarTitle(Text("All"))
                }
            }
        }
    }
}

extension AllComponent {
    struct Properties {
        let state: AllState
        
        var loading: () -> Loading
        var message: (String) -> Message
        var details: (Beer) -> Details
    }
}

// MARK: - Previews
struct AllComponent_Previews: PreviewProvider {
    static var previews: some View {
        AllComponent(properties: .init(
            state: .loading,
            loading: { RenderContainer(view: LoadingComponent_Previews.previews) },
            message: { _ in RenderContainer(view: MessageComponent_Previews.previews) },
            details: { _ in RenderContainer(view: DetailsComponent_Previews.previews) }
        ))
    }
}
