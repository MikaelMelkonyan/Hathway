//
//  AllContainer.swift
//  Hathway
//
//  Created by Mikael Melkonyan on 27.03.2021.
//

struct AllContainer: Container {
    typealias ContainerComponent = AllComponent<LoadingContainer, MessageContainer>
    private var isLoadedBefore = false
    
    func properties(store: AppEnvironmentStore) -> ContainerComponent.Properties {
        .init(state: store.state.allState) {
            LoadingContainer()
        } message: {
            MessageContainer(message: $0)
        }
    }
}
