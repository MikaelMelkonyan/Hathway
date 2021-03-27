//
//  Container.swift
//  Rocket
//
//  Created by Mikael Melkonyan on 25.02.2021.
//  Copyright © 2021 Rocket. All rights reserved.
//

import SwiftUI

protocol Container: View {
    associatedtype ContainerState
    associatedtype ContainerComponent: Component
    
    func properties(store: EnvironmentStore<ContainerState>) -> ContainerComponent.Properties
    
    func onAppear(store: EnvironmentStore<ContainerState>)
    func onDisappear(store: EnvironmentStore<ContainerState>)
}

// MARK: - Default realization
extension Container {
    func onAppear(store: EnvironmentStore<ContainerState>) {}
    func onDisappear(store: EnvironmentStore<ContainerState>) {}
}

// MARK: - Body
extension Container {
    var body: some View {
        connectedContainer()
    }
}

// MARK: - Body. Private
private extension Container {
    @ViewBuilder
    func connectedContainer() -> some View {
        if #available(iOS 14, *) {
            ConnectedContainer<ContainerComponent, ContainerState>(
                properties: properties, onAppear: onAppear, onDisappear: onDisappear
            )
        } else {
            ConnectedContainerIOS13<ContainerComponent, ContainerState>(
                properties: properties, onAppear: onAppear, onDisappear: onDisappear
            )
        }
    }
}

@available(iOS 14, *)
private struct ConnectedContainer<C: Component, State>: View {
    @EnvironmentObject var store: EnvironmentStore<State>
    
    let properties: (_ store: EnvironmentStore<State>) -> C.Properties
    
    var onAppear: (EnvironmentStore<State>) -> Void
    var onDisappear: (EnvironmentStore<State>) -> Void
    
    var body: some View {
        C(properties: properties(store))
            .onAppear { onAppear(store) }
            .onDisappear { onDisappear(store) }
    }
}

// iOS 13 is losing the Environment object in some cases, so we need to cover cases when the store is nil.
private struct ConnectedContainerIOS13<C: Component, State>: View {
    @EnvironmentObject var store: EnvironmentStore<State>
    
    let properties: (_ store: EnvironmentStore<State>) -> C.Properties
    
    var onAppear: (EnvironmentStore<State>) -> Void
    var onDisappear: (EnvironmentStore<State>) -> Void
    
    var body: some View {
        if _store.hasValue {
            CachedStore.store = store
        }
        let currentStore = _store.hasValue ? store : CachedStore.store as! EnvironmentStore<State>
        
        return C(properties: properties(currentStore))
            .onAppear { onAppear(store) }
            .onDisappear { onDisappear(store) }
    }
}

// MARK: - EnvironmentObject extension
private extension EnvironmentObject {
    var hasValue: Bool {
        !String(describing: self).contains("_store: nil")
    }
}

private enum CachedStore {
    static var store: Any!
}
