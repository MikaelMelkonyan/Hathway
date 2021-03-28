//
//  MessageComponent.swift
//  Hathway
//
//  Created by Mikael Melkonyan on 27.03.2021.
//

import SwiftUI

struct MessageComponent: Component {
    let properties: Properties
    
    var body: some View {
        Text(properties.message)
            .padding()
    }
}

extension MessageComponent {
    struct Properties {
        let message: String
    }
}

// MARK: - Previews
struct MessageComponent_Previews: PreviewProvider {
    static var previews: some View {
        MessageComponent(properties: .init(
            message: "Test"
        ))
    }
}
