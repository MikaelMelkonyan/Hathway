//
//  Middlewareable.swift
//  Hathway
//
//  Created by Mikael Melkonyan on 27.03.2021.
//

import Foundation

protocol Middlewareable: AnyObject {
    associatedtype State
    
    var store: Store<State> { get }
    var queue: DispatchQueue { get }
    
    func sink(action: Actionable)
}
