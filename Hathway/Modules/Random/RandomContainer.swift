//
//  RandomContainer.swift
//  Hathway
//
//  Created by Mikael Melkonyan on 27.03.2021.
//

struct RandomContainer: Container {
    typealias ContainerComponent = RandomComponent<LoadingContainer, MessageContainer, DetailsContainer>
    
    func properties(store: AppEnvironmentStore) -> ContainerComponent.Properties {
        .init(state: store.state.randomItem) {
            LoadingContainer()
        } message: {
            MessageContainer(message: $0)
        } details: {
            DetailsContainer(beer: $0, isRandom: true)
        }
    }
}
