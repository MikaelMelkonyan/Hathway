//
//  LoadingContainer.swift
//  Hathway
//
//  Created by Mikael Melkonyan on 27.03.2021.
//

struct LoadingContainer: Container {
    typealias ContainerComponent = LoadingComponent
    
    func properties(store: AppEnvironmentStore) -> ContainerComponent.Properties {
        .init()
    }
}
