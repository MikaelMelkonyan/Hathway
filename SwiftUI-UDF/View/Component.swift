//
//  Component.swift
//  Hathway
//
//  Created by Mikael Melkonyan on 25.02.2021.
//  Copyright © 2021 Hathway. All rights reserved.
//

import SwiftUI

protocol Component: View {
    associatedtype Properties
    
    var properties: Properties { get }
    init(properties: Properties)
}
