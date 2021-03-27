//
//  RandomContainer.swift
//  Hathway
//
//  Created by Mikael Melkonyan on 27.03.2021.
//

struct RandomContainer: Container {
    typealias ContainerComponent = RandomComponent
    
    func properties(store: AppEnvironmentStore) -> ContainerComponent.Properties {
        .init()
    }
}
