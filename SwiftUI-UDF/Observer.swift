//
//  Observer.swift
//  Rocket
//
//  Created by Mikael Melkonyan on 26.02.2021.
//  Copyright © 2021 Rocket. All rights reserved.
//

import Foundation

final class Observer<State> {
    private let queue: DispatchQueue
    private let observe: (State) -> Void
    
    init(queue: DispatchQueue, observe: @escaping (State) -> Void) {
        self.queue = queue
        self.observe = observe
    }
}

// MARK: - Internal
extension Observer {
    func observe(new state: State) {
        queue.sync {
            observe(state)
        }
    }
}

// MARK: - Hashable
extension Observer: Hashable {
    static func == (lhs: Observer<State>, rhs: Observer<State>) -> Bool {
        ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    
    func hash(into hasher: inout Hasher) {
        ObjectIdentifier(self).hash(into: &hasher)
    }
}
