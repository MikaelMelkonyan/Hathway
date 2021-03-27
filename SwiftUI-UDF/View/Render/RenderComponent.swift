//
//  RenderComponent.swift
//  Rocket
//
//  Created by Mikael Melkonyan on 08.03.2021.
//  Copyright © 2021 Rocket. All rights reserved.
//

import SwiftUI

struct RenderComponent<V: View>: Component {
    let properties: Properties
    
    init(properties: Properties) {
        self.properties = properties
    }
    
    var body: some View {
        properties.view
    }
}

// MARK: - Model
extension RenderComponent {
    struct Properties {
        var view: V
    }
}
