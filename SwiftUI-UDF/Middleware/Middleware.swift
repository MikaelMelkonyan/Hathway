//
//  Middleware.swift
//  Hathway
//
//  Created by Mikael Melkonyan on 27.03.2021.
//

import Foundation
import Combine

class Middleware<State>: Middlewareable {
    let store: Store<State>
    let queue: DispatchQueue
    
    init(store: Store<State>, queue: DispatchQueue) {
        self.store = store
        self.queue = queue
    }
    
    required init(store: Store<State>) {
        self.store = store
        
        let queueLabel = String(describing: Self.self)
        self.queue = DispatchQueue(label: queueLabel)
    }
    
    func sink(action: Actionable) {
        preconditionFailure("Must be implemented in subclass")
    }
}

// MARK: - Hashable
extension Middleware: Hashable {
    static func == (lhs: Middleware<State>, rhs: Middleware<State>) -> Bool {
        ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    
    func hash(into hasher: inout Hasher) {
        ObjectIdentifier(self).hash(into: &hasher)
    }
}
