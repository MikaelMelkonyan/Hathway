//
//  EnvironmentStore.swift
//  Rocket
//
//  Created by Mikael Melkonyan on 25.02.2021.
//  Copyright © 2021 Rocket. All rights reserved.
//

import Combine

final class EnvironmentStore<State>: ObservableObject {
    let store: Store<State>
    
    init(store: Store<State>) {
        self.store = store
        self.state = store.state
        
        store.subscribe(observer: asObserver)
    }
    
    @Published private(set) var state: State
}

// MARK: - Internal
extension EnvironmentStore {
    func dispatch<Action: Actionable>(_ action: Action) {
        store.dispatch(action: action)
    }
    
    func dispatch<Action: Actionable>(_ actions: [Action]) {
        store.dispatch(actions: actions)
    }
    
    func bind<Action: Actionable>(_ action: Action) -> Command {
        return { self.dispatch(action) }
    }
    
    func bind<T, Action: Actionable>(_ action: @escaping (T) -> Action) -> CommandWith<T> {
        return { value in self.dispatch(action(value)) }
    }
}

// MARK: - Private
private extension EnvironmentStore {
    var asObserver: Observer<State> {
        Observer(queue: .main) { self.state = $0 }
    }
}
