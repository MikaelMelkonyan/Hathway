//
//  AllContainer.swift
//  Hathway
//
//  Created by Mikael Melkonyan on 27.03.2021.
//

struct AllContainer: Container {
    typealias ContainerComponent = AllComponent
    
    func properties(store: AppEnvironmentStore) -> ContainerComponent.Properties {
        .init()
    }
}