//
//  MessageContainer.swift
//  Hathway
//
//  Created by Mikael Melkonyan on 27.03.2021.
//

struct MessageContainer: Container {
    typealias ContainerComponent = MessageComponent
    
    let message: String
    
    func properties(store: AppEnvironmentStore) -> ContainerComponent.Properties {
        .init(message: message)
    }
}
