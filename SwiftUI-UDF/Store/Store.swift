//
//  Store.swift
//  Rocket
//
//  Created by Mikael Melkonyan on 25.02.2021.
//  Copyright © 2021 Rocket. All rights reserved.
//

import Foundation

final class Store<State> {
    typealias Reducer = (inout State, Actionable) -> Void
    private let queue = DispatchQueue(label: "Store queue", qos: .userInitiated)
    
    private let reducer: Reducer
    private(set) var state: State
    
    init(initial state: State, reducer: @escaping Reducer) {
        self.reducer = reducer
        self.state = state
    }
    
    init(initial state: State) where State: Reducible {
        self.state = state
        self.reducer = { state, action in
            state.reduce(action)
        }
    }
    
    private var observers = Set<Observer<State>>()
}

// MARK: - Internal
extension Store {
    func dispatch<Action: Actionable>(action: Action) {
        queue.async {
            var newState = self.state
            self.reducer(&newState, action)
            self.state = newState
            self.observers.forEach { $0.observe(new: self.state) }
        }
    }
    
    func dispatch<Action: Actionable>(actions: [Action]) {
        queue.async {
            var newState = self.state
            actions.forEach {
                self.reducer(&newState, $0)
            }
            self.state = newState
            self.observers.forEach { $0.observe(new: self.state) }
        }
    }
    
    func subscribe(observer: Observer<State>) {
        queue.async {
            self.observers.insert(observer)
            observer.observe(new: self.state)
        }
    }
}
